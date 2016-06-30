//
//  ButtonsView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ButtonsView.h"
#import "SpecialBtn.h"

@interface ButtonsView ()
{
    NSArray         *_btnArray;
    CAShapeLayer    *_pathLayer;
    UIDynamicAnimator *_animator;
}

@end

@implementation ButtonsView



- (instancetype)initWithFrame:(CGRect)frame btnsArray:(NSArray *)btnArray
{
    self = [super initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
    
    if (self) {
        self.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
        _btnArray = btnArray;
        _aniamtionDuring = 2.0;
        
        _pathLayer = [CAShapeLayer layer];
        
        if (!_animator) {
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        }
    }
    
    return self;
}


- (void)showBtnsAnimation
{
//    [_beizerPath removeAllPoints];
//    [_beizerPath moveToPoint:CGPointMake(10, 10)];
//    [_beizerPath addLineToPoint:CGPointMake(self.width - 10, self.height - 10)];
//
    
    //  temppath
    UIBezierPath *tempPath = [[UIBezierPath alloc] init];
    [tempPath moveToPoint:CGPointMake(0, 100)];
    [tempPath addQuadCurveToPoint:CGPointMake(self.width, 100) controlPoint:CGPointMake(self.width / 2.0, self.height)];
    _beizerPath = tempPath;
    
    
    _pathLayer.path = _beizerPath.CGPath;
    _pathLayer.fillColor = [UIColor clearColor].CGColor;
    _pathLayer.strokeColor = [UIColor orangeColor].CGColor;
    _pathLayer.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer];
    
//    for (int i = 0; i < [_btnArray count]; i++) {
//        
//        SpecialBtn *specialBtn = _btnArray[i];
//        [self addSubview:specialBtn];
//        
//        specialBtn.keyFrameAniamtion.keyPath = @"position";
//        specialBtn.keyFrameAniamtion.path = _beizerPath.CGPath;
//        specialBtn.keyFrameAniamtion.fillMode = kCAFillModeForwards;
//        specialBtn.keyFrameAniamtion.removedOnCompletion = NO;
//        specialBtn.keyFrameAniamtion.keyTimes = @[
//                                                  [NSNumber numberWithFloat:0.1],
//                                                  [NSNumber numberWithFloat:0.2],
////                                                  [NSNumber numberWithFloat:0.3],
//                                                  [NSNumber numberWithFloat:0.5]
//                                                  ];
//        [specialBtn.keyFrameAniamtion setDuration:_aniamtionDuring];
//        
//        [specialBtn.layer addAnimation:specialBtn.keyFrameAniamtion forKey:specialBtn.keyFrameAniamtion.keyPath];
////        specialBtn.keyFrameAniamtion.s
//    }
    
    
    [self tempBehavior];
    
    return;
    
    
    UIButton *tempBtn = _btnArray[0];
    [self addSubview:tempBtn];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:tempBtn];
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:tempBtn attachedToAnchor:CGPointMake(self.width / 2.0, 10)];
    
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.resistance = 0.2;
    
//    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] init];
//    dynamicItemBehavior.density = 100;
//    dynamicItemBehavior.resistance = 10;
//    
//    CGPoint currentVelocity = [dynamicItemBehavior linearVelocityForItem:self.item];
//    CGPoint velocityDelta = CGPointMake(velocity.x - currentVelocity.x, velocity.y - currentVelocity.y);
//    [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];
//
//    
//    [dynamicItemBehavior addLinearVelocity:CGPointMake(tempBtn.x + 100, tempBtn.y) forItem:tempBtn];
    
    UICollisionBehavior *collosionBehavior = [[UICollisionBehavior alloc] init];
    [collosionBehavior addItem:tempBtn];
    collosionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collosionBehavior addBoundaryWithIdentifier:@"path" forPath:_beizerPath];
    
    [_animator addBehavior:gravityBehavior];
    [_animator addBehavior:attachmentBehavior];
    [_animator addBehavior:itemBehavior];
//    [_animator addBehavior:dynamicItemBehavior];
    [_animator addBehavior:collosionBehavior];
}

- (void)tempBehavior
{
    UIButton *tempBtn = _btnArray[0];
    [self addSubview:tempBtn];
    
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:tempBtn];
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.resistance = 0.2;
    UICollisionBehavior * collisitionBehavior = [[UICollisionBehavior alloc] init];
    [collisitionBehavior addItem:tempBtn];
    collisitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    [collisitionBehavior addBoundaryWithIdentifier:@"Button" forPath:[UIBezierPath bezierPathWithRect:self.snapBUtton.frame]];
//    [collisitionBehavior addBoundaryWithIdentifier:@"path" fromPoint:CGPointMake(0, 100) toPoint:CGPointMake(200, 200)];
    
    UIBezierPath *tempPath = [UIBezierPath bezierPath];
    [tempPath moveToPoint:CGPointMake(0, 50)];
    [tempPath addLineToPoint:CGPointMake(200, 150)];
    [collisitionBehavior addBoundaryWithIdentifier:@"path" forPath:tempPath];
    
    [_animator addBehavior:collisitionBehavior];
    [_animator addBehavior:itemBehavior];
    [_animator addBehavior:gravityBehavior];
}

- (void)closeBtnsAniamtion
{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
