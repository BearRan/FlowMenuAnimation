//
//  AssignPointView.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat poindWidth = 20;

@interface AssignPointView : UIView

@property (assign, nonatomic) CGPoint       startPoint;
@property (assign, nonatomic) CGPoint       finalPoint;
@property (strong, nonatomic) CAShapeLayer  *presentationLayer; //演示层
@property (assign, nonatomic) CGPoint       prePosition;       //演示层position

+ (AssignPointView *)normalPointView_width:(CGFloat)width fillColor:(UIColor *)fillColor;

+ (AssignPointView *)normalPointView;

+ (AssignPointView *)normalPointView_inView:(UIView *)inView finalPoint:(CGPoint)finalPoint;

//  只有一个点，不会变，左上角和右上角的点
+ (AssignPointView *)normalPointView_inView:(UIView *)inView onlyPoint:(CGPoint)onlyPoint;

- (void)setCenter_start;
- (void)setCenter_final;

@end
