//
//  UIView+SetSize.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "UIView+SetSize.h"

static CGFloat origin_width = 896;
static CGFloat origin_height = 483;

@implementation UIView (SetSize)

- (CGFloat)setXX:(CGFloat)xx
{
    CGFloat reffer_width = origin_width;
    CGFloat returnXX = 1.0 * xx / reffer_width * self.width;
    
    return returnXX;
}

- (CGPoint)setPoint:(CGFloat)x y:(CGFloat)y
{
    CGFloat reffer_width = origin_width;
    CGFloat reffer_height = origin_height;
    
    CGPoint returnPoint = CGPointMake(1.0 * x / reffer_width * self.width, 1.0 * y / reffer_height * self.height);
    return returnPoint;
}

@end
