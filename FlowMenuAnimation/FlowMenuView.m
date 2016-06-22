//
//  FlowMenuView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "FlowMenuView.h"
#import "AssignPointView.h"

@interface FlowMenuView ()
{
    AssignPointView *_controlPoint_1;
    AssignPointView *_controlPoint_2;
    
    UIBezierPath *_bezierPath_downGroove;
    UIBezierPath *_bezierPath_grooveBg;
    
    CAShapeLayer *_grooveBgLayer;
}

@end

@implementation FlowMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    CGFloat controlPoint_1_x = 191.0 / 372 * self.width;
    CGFloat controlPoint_1_y = 10;
    _controlPoint_1 = [AssignPointView normalPointView];
    _controlPoint_1.center = CGPointMake(controlPoint_1_x, controlPoint_1_y);
    [self addSubview:_controlPoint_1];
    
    
    CGFloat controlPoint_2_x = 274.0 / 372 * self.width;
    CGFloat controlPoint_2_y = 324;
    _controlPoint_2 = [AssignPointView normalPointView];
    _controlPoint_2.center = CGPointMake(controlPoint_2_x, controlPoint_2_y);
    [self addSubview:_controlPoint_2];
    
    CGPoint startPoint = CGPointMake(85.0 / 372 * self.width, 0);
    CGPoint endPoint = CGPointMake(self.width * 1.3, 0);
    
    _bezierPath_downGroove = [UIBezierPath bezierPath];
    [_bezierPath_downGroove moveToPoint:CGPointMake(0, 0)];
    [_bezierPath_downGroove addLineToPoint:startPoint];
    [_bezierPath_downGroove addCurveToPoint:endPoint controlPoint1:_controlPoint_1.layer.position controlPoint2:_controlPoint_2.layer.position];
    
    _bezierPath_grooveBg = [UIBezierPath bezierPath];
    [_bezierPath_grooveBg appendPath:_bezierPath_downGroove];
    [_bezierPath_grooveBg addLineToPoint:CGPointMake(0, 0)];
    [_bezierPath_grooveBg closePath];
    
    _grooveBgLayer = [CAShapeLayer layer];
    _grooveBgLayer.path = _bezierPath_grooveBg.CGPath;
    _grooveBgLayer.fillColor = UIColorFromHEX(0xe6425f).CGColor;
    [self.layer addSublayer:_grooveBgLayer];
    
    
    [self bringSubviewToFront:_controlPoint_1];
    [self bringSubviewToFront:_controlPoint_2];
}

@end








