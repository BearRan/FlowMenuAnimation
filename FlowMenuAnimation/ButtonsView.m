//
//  ButtonsView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ButtonsView.h"
#import "SpecialBtn.h"

@interface ButtonsView () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
{
    NSArray         *_btnArray;
    CAShapeLayer    *_pathLayer;
    UIDynamicAnimator *_animator;
    UIAttachmentBehavior    *_firstBtnDragBehavior;
    CADisplayLink   *_displayLink;
    
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
        
        _btnArray = btnArray;
        _aniamtionDuring = 2.0;
        
        _pathLayer = [CAShapeLayer layer];
        
        if (!_animator) {
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
            _animator.delegate = self;
        }
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
        _tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_tapGesture];
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureEvent:)];
        [self addGestureRecognizer:_panGesture];
        
//        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(checkIntersects)];
//        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        _displayLink.paused = YES;
    }
    
    return self;
}


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

- (CGFloat)setXX:(CGFloat)xx
{
    CGFloat reffer_width = 896;
    CGFloat returnXX = 1.0 * xx / reffer_width * self.width;
    
    return returnXX;
}


- (void)showBtnsAnimation
{
    _displayLink.paused = NO;
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
            UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_btnArray[i] attachedToItem:_btnArray[i - 1]];
            [attachmentBehavior setLength:tempBtn.width + 10];
            [attachmentBehavior setDamping:10.01];
            [attachmentBehavior setFrequency:1];
            [_animator addBehavior:attachmentBehavior];
            
        }
        
        //  重力行为
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
        [gravityBehavior addItem:tempBtn];
        
        //  最后一个球处理
        if (i == [_btnArray count] - 1) {
            
            __block CGPoint positionLast = CGPointMake(0, 0);
            __block BOOL needSnap = NO;
            
            [gravityBehavior setAction:^{
                
                if (needSnap == NO) {
                    CGPoint positionNow = tempBtn.layer.position;
                    
                    //  right
                    if (positionNow.x - positionLast.x >= 0) {
                        nil;
                    }
                    //  left
                    else{
                        
                        needSnap = YES;
                        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:tempBtn snapToPoint:CGPointMake(162, 81)];
                        snapBehavior.damping = 1.0;
                        [_animator addBehavior:snapBehavior];
                    }
                    
                    positionLast = positionNow;
                }
            }];
        }

        //  碰撞行为
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
        [collisionBehavior addItem:tempBtn];
        [collisionBehavior addBoundaryWithIdentifier:@"path" forPath:_beizerPath];
        
        //  动力元素行为
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[tempBtn]];
        itemBehavior.resistance = 0.2;
        itemBehavior.allowsRotation = YES;
        itemBehavior.angularResistance = 5.0;
        itemBehavior.friction = 0.8;
        
        
        [_animator addBehavior:gravityBehavior];
        [_animator addBehavior:collisionBehavior];
        [_animator addBehavior:itemBehavior];
    }
    
    //  碰撞行为
//    UICollisionBehavior *collisionBehavior1 = [[UICollisionBehavior alloc] initWithItems:@[_btnArray[0]]];
    UICollisionBehavior *collisionBehavior1 = [[UICollisionBehavior alloc] initWithItems:_btnArray];
    collisionBehavior1.collisionDelegate = self;
//    [_animator addBehavior:collisionBehavior1];
    
    [self pushBehavior];
    
}

- (void)pushBehavior
{
    
    UIButton *tempBtn = _btnArray[0];
    
    UIPushBehavior * push = [[UIPushBehavior alloc] initWithItems:@[tempBtn] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(200, tempBtn.centerY);
    push.magnitude = 0.1;
    
    [_animator addBehavior:push];
}

- (void)closeBtnsAniamtion
{

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


#pragma mark - 检测1，2按钮重叠
- (void)checkIntersects
{
    SpecialBtn *item1_btn = (SpecialBtn *)_btnArray[0];
    SpecialBtn *item2_btn = (SpecialBtn *)_btnArray[1];
    
    BOOL haveIntersects = CGRectIntersectsRect(item1_btn.frame, item2_btn.frame);
    CGRect intersectRect = CGRectIntersection(item1_btn.frame, item2_btn.frame);
    
    if (haveIntersects == YES) {
        NSLog(@"--  haveIntersects intersectRect:%@", NSStringFromCGRect(intersectRect));
    }else{
        NSLog(@"--noIntersects intersectRect:%@", NSStringFromCGRect(intersectRect));
    }
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{
    NSLog(@"--dynamicAnimatorWillResume");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    NSLog(@"--dynamicAnimatorDidPause");
    _displayLink.paused = YES;
}


#pragma mark - UICollisionBehaviorDelegate

//  物体和物体的碰撞代理
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    SpecialBtn *item1_btn = (SpecialBtn *)item1;
    SpecialBtn *item2_btn = (SpecialBtn *)item2;
    
    NSLog(@"--1 began item1:%ld item1:%ld point:%@", (long)item1_btn.tag, (long)item2_btn.tag, NSStringFromCGPoint(p));
    
//    NSLog(@"--1 collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p");
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    SpecialBtn *item1_btn = (SpecialBtn *)item1;
    SpecialBtn *item2_btn = (SpecialBtn *)item2;
    
    NSLog(@"--1 end item1:%ld item1:%ld", (long)item1_btn.tag, (long)item2_btn.tag);
    
//    NSLog(@"--2 collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2");
}

//  物体和边界的碰撞代理
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"--3 beganContact Item:%@ point:%@", item, NSStringFromCGPoint(p));
    
//    NSLog(@"--3 collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p");
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    NSLog(@"--4 endedContact Item:%@", item);
    
//    NSLog(@"--4 collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier");
}



@end
