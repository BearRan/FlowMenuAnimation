//
//  FlowMenuViewself.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "FlowMenuViewCell.h"

@implementation FlowMenuViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataModel:(CellDataModel *)dataModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat width = WIDTH;
        CGFloat height = 220.0 / 372 * width;
        
        _flowMenuView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 0, width, height) withDataModel:dataModel];
        [self loadData:dataModel];
        [self.contentView addSubview:_flowMenuView];
    }
    
    return self;
}

- (void)loadData:(CellDataModel *)dataModel
{
    self.flowMenuView.mainInfoView.label.text = dataModel.nameStr;
    self.flowMenuView.mainInfoView.imageView.image = [UIImage imageNamed:dataModel.imageNameStr];
    self.flowMenuView.assignInfoView.assignCellView_1.numLabel.text = dataModel.followersNum;
    self.flowMenuView.assignInfoView.assignCellView_2.numLabel.text = dataModel.favoritesNum;
    self.flowMenuView.assignInfoView.assignCellView_3.numLabel.text = dataModel.viewsNum;
    self.flowMenuView.assignInfoView.assignCellView_1.titleLabel.text = @"FOLLOWERS";
    self.flowMenuView.assignInfoView.assignCellView_2.titleLabel.text = @"FAVORITES";
    self.flowMenuView.assignInfoView.assignCellView_3.titleLabel.text = @"VIEWS";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_flowMenuView.assignInfoView layoutSubviews];
}

@end
