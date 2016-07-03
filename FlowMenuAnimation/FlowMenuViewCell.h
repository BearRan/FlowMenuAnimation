//
//  FlowMenuViewCell.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowMenuView.h"
#import "CellDataModel.h"

@interface FlowMenuViewCell : UITableViewCell

@property (strong, nonatomic) FlowMenuView *flowMenuView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDataModel:(CellDataModel *)dataModel;

@end
