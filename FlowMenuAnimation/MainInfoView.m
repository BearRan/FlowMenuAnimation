//
//  MainInfoView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "MainInfoView.h"

@implementation MainInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
        
        _label = [UILabel new];
        _label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:20];
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [_imageView sizeToFit];
    [_label sizeToFit];
    
    [UIView BearAutoLayViewArray:(NSMutableArray *)self.subviews layoutAxis:kLAYOUT_AXIS_X center:YES gapDistance:10];
}

@end
