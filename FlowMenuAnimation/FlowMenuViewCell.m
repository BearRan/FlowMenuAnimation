//
//  FlowMenuViewCell.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "FlowMenuViewCell.h"

@implementation FlowMenuViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat width = WIDTH;
        CGFloat height = 220.0 / 372 * width;
        
        _flowMenuView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        _flowMenuView.mainInfoView.label.text = @"Night life";
        _flowMenuView.mainInfoView.imageView.image = [UIImage imageNamed:@"wine"];
        _flowMenuView.assignInfoView.assignCellView_1.numLabel.text = @"517";
        _flowMenuView.assignInfoView.assignCellView_2.numLabel.text = @"315";
        _flowMenuView.assignInfoView.assignCellView_3.numLabel.text = @"7815";
        _flowMenuView.assignInfoView.assignCellView_1.titleLabel.text = @"FOLLOWERS";
        _flowMenuView.assignInfoView.assignCellView_2.titleLabel.text = @"FAVORITES";
        _flowMenuView.assignInfoView.assignCellView_3.titleLabel.text = @"VIEWS";

        [self.contentView addSubview:_flowMenuView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_flowMenuView.assignInfoView layoutSubviews];
}

@end
