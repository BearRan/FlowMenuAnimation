//
//  AssignPointView.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignPointView : UIView

@property (assign, nonatomic) CGPoint   startPoint;
@property (assign, nonatomic) CGPoint   finalPoint;

+ (AssignPointView *)normalPointView_width:(CGFloat)width fillColor:(UIColor *)fillColor;

+ (AssignPointView *)normalPointView;

+ (AssignPointView *)normalPointView_inView:(UIView *)inView finalPoint:(CGPoint)finalPoint;

- (void)setCenter_start;
- (void)setCenter_final;

@end
