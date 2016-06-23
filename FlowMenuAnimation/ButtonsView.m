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
    }
    
    return self;
}


- (void)showBtnsAnimation
{
    [_beizerPath removeAllPoints];
    [_beizerPath moveToPoint:CGPointMake(10, 10)];
    [_beizerPath addLineToPoint:CGPointMake(self.width - 10, self.height - 10)];
    
    _pathLayer.path = _beizerPath.CGPath;
    _pathLayer.fillColor = [UIColor clearColor].CGColor;
    _pathLayer.strokeColor = [UIColor orangeColor].CGColor;
    _pathLayer.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer];
    
    for (int i = 0; i < [_btnArray count]; i++) {
        
        SpecialBtn *specialBtn = _btnArray[i];
        [self addSubview:specialBtn];
        
        specialBtn.keyFrameAniamtion.keyPath = @"position";
        specialBtn.keyFrameAniamtion.path = _beizerPath.CGPath;
        specialBtn.keyFrameAniamtion.fillMode = kCAFillModeForwards;
        specialBtn.keyFrameAniamtion.removedOnCompletion = NO;
        specialBtn.keyFrameAniamtion.keyTimes = @[
                                                  [NSNumber numberWithFloat:0.1],
                                                  [NSNumber numberWithFloat:0.2],
//                                                  [NSNumber numberWithFloat:0.3],
                                                  [NSNumber numberWithFloat:0.5]
                                                  ];
        [specialBtn.keyFrameAniamtion setDuration:_aniamtionDuring];
        
        [specialBtn.layer addAnimation:specialBtn.keyFrameAniamtion forKey:specialBtn.keyFrameAniamtion.keyPath];
//        specialBtn.keyFrameAniamtion.s
    }
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
