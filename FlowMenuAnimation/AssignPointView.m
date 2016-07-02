//
//  AssignPointView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "AssignPointView.h"

@implementation AssignPointView

+ (AssignPointView *)normalPointView_width:(CGFloat)width fillColor:(UIColor *)fillColor
{
    AssignPointView *assignPointView = [[AssignPointView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    assignPointView.backgroundColor = fillColor;
    assignPointView.layer.cornerRadius = assignPointView.width / 2.0;
    assignPointView.layer.masksToBounds = YES;
    
    return assignPointView;
}


+ (AssignPointView *)normalPointView
{
    AssignPointView *assignPointView = [[AssignPointView alloc] initWithFrame:CGRectMake(0, 0, poindWidth, poindWidth)];
    if (showAssistantPoint == YES) {
        assignPointView.backgroundColor = [UIColor blackColor];
    }else{
        assignPointView.backgroundColor = [UIColor clearColor];
    }
    assignPointView.layer.cornerRadius = assignPointView.width / 2.0;
    assignPointView.layer.masksToBounds = YES;
    
    return assignPointView;
}

+ (AssignPointView *)normalPointView_inView:(UIView *)inView finalPoint:(CGPoint)finalPoint
{
    AssignPointView *assignPointView = [[AssignPointView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    if (showAssistantPoint == YES) {
        assignPointView.backgroundColor = [UIColor blackColor];
    }else{
        assignPointView.backgroundColor = [UIColor clearColor];
    }
    assignPointView.layer.cornerRadius = assignPointView.width / 2.0;
    assignPointView.layer.masksToBounds = YES;
    assignPointView.finalPoint = finalPoint;
    
    [assignPointView setStartY];
    
    [inView addSubview:assignPointView];
    assignPointView.center = assignPointView.startPoint;
    
    return assignPointView;
}

//  只有一个点，不会变，左上角和右上角的点
+ (AssignPointView *)normalPointView_inView:(UIView *)inView onlyPoint:(CGPoint)onlyPoint
{
    AssignPointView *assignPointView = [[AssignPointView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    if (showAssistantPoint == YES) {
        assignPointView.backgroundColor = [UIColor blackColor];
    }else{
        assignPointView.backgroundColor = [UIColor clearColor];
    }
    assignPointView.layer.cornerRadius = assignPointView.width / 2.0;
    assignPointView.layer.masksToBounds = YES;
    assignPointView.startPoint = onlyPoint;
    
    [assignPointView setStartY];
    
    [inView addSubview:assignPointView];
    assignPointView.center = assignPointView.startPoint;
    
    
    return assignPointView;
}

- (void)setStartY
{
    self.startPoint = CGPointMake(self.startPoint.x, - 50);
}

- (void)setCenter_start
{
    self.center = _startPoint;
}

- (void)setCenter_final
{
    self.center = _finalPoint;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}

@synthesize finalPoint = _finalPoint;
- (void)setFinalPoint:(CGPoint)finalPoint
{
    _finalPoint = finalPoint;
    
    _startPoint = CGPointMake(finalPoint.x, 0);
}

@synthesize presentationLayer = _presentationLayer;
- (CAShapeLayer *)presentationLayer
{
    _presentationLayer = self.layer.presentationLayer;
    return _presentationLayer;
}

@synthesize prePosition = _prePosition;
- (CGPoint)prePosition
{
    _prePosition = self.presentationLayer.position;
    return _prePosition;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
