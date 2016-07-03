//
//  AssignInfoView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "AssignInfoView.h"

@implementation AssignInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _assignCellView_1 = [AssignInfoSingleCellView new];
        [_assignCellView_1 setHeight:self.height];
        [self addSubview:_assignCellView_1];
        
        _assignCellView_2 = [AssignInfoSingleCellView new];
        [_assignCellView_2 setHeight:self.height];
        [self addSubview:_assignCellView_2];
        
        _assignCellView_3 = [AssignInfoSingleCellView new];
        [_assignCellView_3 setHeight:self.height];
        [self addSubview:_assignCellView_3];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView BearAutoLayViewArray:(NSMutableArray *)self.subviews layoutAxis:kLAYOUT_AXIS_X center:YES gapDistance:30];
}

@end
