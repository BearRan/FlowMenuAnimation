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
    AssignPointView *assignPointView = [[AssignPointView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    assignPointView.backgroundColor = [UIColor blackColor];
    assignPointView.layer.cornerRadius = assignPointView.width / 2.0;
    assignPointView.layer.masksToBounds = YES;
    
    return assignPointView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
