//
//  ButtonsView.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonsView : UIView

@property (strong, nonatomic) UIBezierPath  *beizerPath;

- (instancetype)initWithFrame:(CGRect)frame btnsArray:(NSArray *)btnArray;

- (void)showBtnsAnimation;
- (void)closeBtnsAniamtion;

@end
