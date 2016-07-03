//
//  FlowMenuView.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainInfoView.h"
#import "AssignInfoView.h"
#import "CellDataModel.h"

@interface FlowMenuView : UIView

@property (strong, nonatomic) MainInfoView      *mainInfoView;
@property (strong, nonatomic) AssignInfoView    *assignInfoView;

- (instancetype)initWithFrame:(CGRect)frame withDataModel:(CellDataModel *)dataModel;

@end
