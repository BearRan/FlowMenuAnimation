//
//  ButtonsView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ButtonsView.h"
#import "SpecialBtn.h"
#import "UIView+SetSize.h"

typedef enum {
    kAnimatorStatus_null,
    kAnimatorStatus_open,
    kAnimatorStatus_close,
}AnimatorStatus;

@interface ButtonsView () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
{
    NSArray                 *_btnArray;
    CAShapeLayer            *_pathLayer;
    UIDynamicAnimator       *_animator;
    UIAttachmentBehavior    *_firstBtnDragBehavior;
    AnimatorStatus          _animatorStatus;
    
    UITapGestureRecognizer  *_tapGesture;
    UIPanGestureRecognizer  *_panGesture;
}

@end

@implementation ButtonsView



- (instancetype)initWithFrame:(CGRect)frame btnsArray:(NSArray *)btnArray
{
    self = [super initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height)];
    
    if (self) {
        
        if (showPathBgViewColor == YES) {
            self.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
        
        _btnArray       = btnArray;
        _animatorStatus = kAnimatorStatus_null;
        _pathLayer      = [CAShapeLayer layer];
        
        if (!_animator) {
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
            _animator.delegate = self;
        }
        
        if (needDragGesture) {
            _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
            _tapGesture.numberOfTapsRequired = 1;
            [self addGestureRecognizer:_tapGesture];
            
            _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
            [self addGestureRecognizer:_panGesture];
        }
    }
    
    return self;
}


#pragma mark - 显现／消退动画

#pragma mark 显现动画
- (void)showBtnsAnimation
{
    _animatorStatus = kAnimatorStatus_open;
    [_animator removeAllBehaviors];
    
    if (showPath) {
        _pathLayer.path = _beizerPath.CGPath;
        _pathLayer.fillColor = [UIColor clearColor].CGColor;
        _pathLayer.strokeColor = [UIColor orangeColor].CGColor;
        _pathLayer.lineWidth = 2.0;
        [self.layer addSublayer:_pathLayer];
    }
    
    CGFloat btn_gap = [self setXX:16];
    for (int i = 0; i < [_btnArray count]; i++) {
        
        SpecialBtn *tempBtn = _btnArray[i];
        tempBtn.tag = i;
        [self addSubview:tempBtn];
        
        //  设定初始位置
        [tempBtn setX:(tempBtn.width + btn_gap) * ([_btnArray count] - 1 - i) + btn_gap];
        [tempBtn setY:-tempBtn.height];
        
        //  添加球与球之间的附着行为
        if (i > 0) {
            [self addAttachmentBehavior_item:_btnArray[i] attachToItem:_btnArray[i - 1]];
        }
        
        //  重力行为
        UIGravityBehavior *gravityBehavior = [self addGravityBehavior:tempBtn];
        if (i == [_btnArray count] - 1) {
            //  最后一个球处理重力行为
            [self dealLastBtnGravityBehavior:gravityBehavior tempBtn:tempBtn];
        }

        //  碰撞行为
        [self addCollisionBehavior:tempBtn];
        
        //  动力元素行为
        UIDynamicItemBehavior *itemBehavior = [self addDynamicItemBehavior:tempBtn];
        if (i == [_btnArray count] - 1) {
            //  最后一个球增加密度,以防止出现的时候，由于惯性的原因导致飞起来
            itemBehavior.density = 1.8;
        }
        
    }
    
    //  第一个球向右的推力
    [self addPushBehavior_inFirstBtn];
}

#pragma mark 消退动画
- (void)closeBtnsAniamtion
{
    NSLog(@"-- closeBtnsAniamtion");
    
    _animatorStatus = kAnimatorStatus_close;
    SpecialBtn *lastBtn = (SpecialBtn *)[_btnArray lastObject];
    
    [_animator removeAllBehaviors];
    
    for (int i = 0; i < [_btnArray count]; i++) {
        
        //  添加球与球之间的附着行为
        if (i > 0) {
            
            UIAttachmentBehavior *attachmentBehavior = [self addAttachmentBehavior_item:_btnArray[i] attachToItem:_btnArray[i - 1]];
            [attachmentBehavior setFrequency:5];
            [attachmentBehavior setLength:lastBtn.width + 5];
        }
        
        //  重力行为
        UIGravityBehavior *gravityBehavior = [self addGravityBehavior:_btnArray[i]];
        if (i == 0) {
            [self dealFirstDisappearBtnGravityBehavior:gravityBehavior tempBtn:_btnArray[i]];
        }
        
        //  碰撞行为
        [self addCollisionBehavior:_btnArray[i]];
        
        //  动力元素行为
        [self addDynamicItemBehavior:_btnArray[i]];
    }
    
    //  最后一个球向左push
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[lastBtn] mode:UIPushBehaviorModeContinuous];
    pushBehavior.pushDirection = CGVectorMake(-1, -0.5);
    pushBehavior.magnitude = 10.0;
    [_animator addBehavior:pushBehavior];
}



#pragma mark - 添加各种行为

#pragma mark  重力行为
- (UIGravityBehavior *)addGravityBehavior:(id <UIDynamicItem>)item
{
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:item];
    [_animator addBehavior:gravityBehavior];
    
    return gravityBehavior;
}

#pragma mark  添加球与球之间的附着行为
- (UIAttachmentBehavior *)addAttachmentBehavior_item:(id <UIDynamicItem>)item attachToItem:(id <UIDynamicItem>)attachToItem
{
    SpecialBtn *tempBtn = (SpecialBtn *)item;
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToItem:attachToItem];
    [attachmentBehavior setLength:tempBtn.width + 20];
    [attachmentBehavior setDamping:10.01];
    [attachmentBehavior setFrequency:1];
    [_animator addBehavior:attachmentBehavior];
    
    return attachmentBehavior;
}

#pragma mark  碰撞行为
- (UICollisionBehavior *)addCollisionBehavior:(id <UIDynamicItem>)item
{
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    [collisionBehavior addItem:item];
    [collisionBehavior addBoundaryWithIdentifier:@"path" forPath:_beizerPath];
    [_animator addBehavior:collisionBehavior];
    
    return collisionBehavior;
}

#pragma mark  动力元素行为
- (UIDynamicItemBehavior *)addDynamicItemBehavior:(id <UIDynamicItem>)item
{
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[item]];
    itemBehavior.resistance = 0;
    itemBehavior.allowsRotation = YES;
    itemBehavior.angularResistance = 4.0;
    itemBehavior.friction = 0.8;
    [_animator addBehavior:itemBehavior];
    
    return itemBehavior;
}

#pragma mark  显现动画，第一个球向右的推力
- (UIPushBehavior *)addPushBehavior_inFirstBtn
{
    UIButton *tempBtn = _btnArray[0];
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[tempBtn] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(1, 0.3);
    pushBehavior.magnitude = 1.6;
    [_animator addBehavior:pushBehavior];
    
    return pushBehavior;
}



#pragma mark  显现动画时，对最后一个球回滚时的立即响应
- (void)dealLastBtnGravityBehavior:(UIGravityBehavior *)gravityBehavior tempBtn:(SpecialBtn *)tempBtn
{
    __block CGPoint positionLast = CGPointMake(0, 0);
    __block BOOL pushLeft = NO;
    
    [gravityBehavior setAction:^{
        
        if (pushLeft == NO) {
            CGPoint positionNow = tempBtn.layer.position;
            
            //  right
            if (positionNow.x - positionLast.x >= 0) {
                nil;
            }
            //  left
            else{
                
                pushLeft = YES;
                
                [_animator removeAllBehaviors];
                
                for (int i = 0; i < [_btnArray count]; i++) {
                    
                    //  添加球与球之间的附着行为
                    if (i > 0) {
                        
                        UIAttachmentBehavior *attachmentBehavior = [self addAttachmentBehavior_item:_btnArray[i] attachToItem:_btnArray[i - 1]];
                        [attachmentBehavior setFrequency:5];
                        [attachmentBehavior setLength:tempBtn.width + 5];
                    }
                    
                    //  重力行为
                    [self addGravityBehavior:_btnArray[i]];
                    
                    //  碰撞行为
                    [self addCollisionBehavior:_btnArray[i]];
                    
                    //  动力元素行为
                    UIDynamicItemBehavior *itemBehavior = [self addDynamicItemBehavior:_btnArray[i]];
                    itemBehavior.angularResistance = 15.0;
                }
                
                //  最后一个球向左push
                UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[tempBtn] mode:UIPushBehaviorModeContinuous];
                pushBehavior.pushDirection = CGVectorMake(-1, -0.5);
                pushBehavior.magnitude = 2.3;
                [_animator addBehavior:pushBehavior];
                
                //  允许点击按钮
                if (_animatorStatus == kAnimatorStatus_open) {
                    if (self.dynamicAnimaionShowFinsh) {
                        self.dynamicAnimaionShowFinsh();
                    }
                }
            }
            
            positionLast = positionNow;
        }
    }];
}

#pragma mark  消退动画时，对一个球消失时的立即响应
- (void)dealFirstDisappearBtnGravityBehavior:(UIGravityBehavior *)gravityBehavior tempBtn:(SpecialBtn *)tempBtn
{
    __block BOOL disAppear = NO;
    
    [gravityBehavior setAction:^{
        
        if (disAppear == NO) {

            if (tempBtn.maxY < 20) {
                
                disAppear = YES;
                if (_animatorStatus == kAnimatorStatus_close) {
                    if (self.dynamicAnimaionCloseFinsh) {
                        self.dynamicAnimaionCloseFinsh();
                    }
                }
            }
        }
        
    }];
}


#pragma mark - 拖动手势

- (void)gestureEvent:(UIGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView:self];
    NSLog(@"tapPoint :%@", NSStringFromCGPoint(touchPoint));
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self initDragBehaviourWithAnchorPosition:touchPoint];
        [_animator addBehavior:_firstBtnDragBehavior];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [_firstBtnDragBehavior setAnchorPoint:touchPoint];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_firstBtnDragBehavior];
    }
}

- (void)initDragBehaviourWithAnchorPosition:(CGPoint)anchorPosition {
    UIView *ballView = [_btnArray lastObject];
    _firstBtnDragBehavior = [[UIAttachmentBehavior alloc] initWithItem:ballView attachedToAnchor:anchorPosition];
    double length = [self getDistanceBetweenAnchor:anchorPosition andBallView:ballView];
    [_firstBtnDragBehavior setLength:((CGFloat) length  < 20) ? (CGFloat) length : 20];
}

- (double)getDistanceBetweenAnchor:(CGPoint)anchor andBallView:(UIView *)ballView {
    return sqrt(pow((anchor.x - ballView.center.x), 2.0) + pow((anchor.y - ballView.center.y), 2.0));
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"--dynamicAnimatorWillResume");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"--dynamicAnimatorDidPause");
}


@end
