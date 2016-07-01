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
    [_animator removeAllBehaviors];
    
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
    
    
//    [self tempBehavior];
    [self tempBehavior_1];
    
}

- (void)tempBehavior_1
{
    UIButton *tempBtn = _btnArray[0];
    [self addSubview:tempBtn];
    
//    [tempBtn setX:170];
    [tempBtn setY:-tempBtn.height];
    
    CAShapeLayer *_pathLayer1 = [CAShapeLayer layer];
    _pathLayer1.path = _beizerPath.CGPath;
    _pathLayer1.fillColor = [UIColor clearColor].CGColor;
    _pathLayer1.strokeColor = [UIColor greenColor].CGColor;
    _pathLayer1.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer1];
    
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:tempBtn];
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.resistance = 0.2;
    UICollisionBehavior * collisitionBehavior = [[UICollisionBehavior alloc] init];
    [collisitionBehavior addItem:tempBtn];
//    collisitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisitionBehavior addBoundaryWithIdentifier:@"path" forPath:_beizerPath];
    
    [_animator addBehavior:collisitionBehavior];
    [_animator addBehavior:itemBehavior];
    [_animator addBehavior:gravityBehavior];
}


- (void)tempBehavior
{
    UIButton *tempBtn = _btnArray[0];
    [self addSubview:tempBtn];
    
//    [tempBtn setX:100];
    
    UIBezierPath *tempPath = [UIBezierPath bezierPath];
    [tempPath moveToPoint:CGPointMake(0, 100)];
    [tempPath addLineToPoint:CGPointMake(300, 200)];
    [tempPath addLineToPoint:CGPointMake(WIDTH, 200)];
    [tempPath addLineToPoint:CGPointMake(WIDTH, 0)];
    [tempPath addLineToPoint:CGPointMake(0, 0)];
    [tempPath closePath];
    
    CAShapeLayer *_pathLayer1 = [CAShapeLayer layer];
    _pathLayer1.path = tempPath.CGPath;
    _pathLayer1.fillColor = [UIColor clearColor].CGColor;
    _pathLayer1.strokeColor = [UIColor greenColor].CGColor;
    _pathLayer1.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer1];
    
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:tempBtn];
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.resistance = 0.2;
    UICollisionBehavior * collisitionBehavior = [[UICollisionBehavior alloc] init];
    [collisitionBehavior addItem:tempBtn];
    collisitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
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
