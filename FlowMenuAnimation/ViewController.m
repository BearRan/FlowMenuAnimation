//
//  ViewController.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "FlowMenuView.h"
#import "FlowMenuViewCell.h"
#import "CellDataModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView     *_mainTableView;
    FlowMenuView    *_flowMenuView;
    NSMutableArray  *_dataModelArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSetDataArray];
    [self createUI];
}

- (void)createUI
{
    if (showSingleFlowDemo == NO) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = UIColorFromHEX(0x61cab4);
        [self.view addSubview:_mainTableView];
    }
    
    else{
        CGFloat width = WIDTH;
        CGFloat height = 220.0 / 372 * width;
        
        CellDataModel *dataModel =_dataModelArray[0];
        _flowMenuView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 200, width, height) withDataModel:dataModel];
        [self loadData:dataModel];
        [self.view addSubview:_flowMenuView];
    }
}

- (void)loadData:(CellDataModel *)dataModel
{
    _flowMenuView.mainInfoView.label.text = dataModel.nameStr;
    _flowMenuView.mainInfoView.imageView.image = [UIImage imageNamed:dataModel.imageNameStr];
    _flowMenuView.assignInfoView.assignCellView_1.numLabel.text = dataModel.followersNum;
    _flowMenuView.assignInfoView.assignCellView_2.numLabel.text = dataModel.favoritesNum;
    _flowMenuView.assignInfoView.assignCellView_3.numLabel.text = dataModel.viewsNum;
    _flowMenuView.assignInfoView.assignCellView_1.titleLabel.text = @"FOLLOWERS";
    _flowMenuView.assignInfoView.assignCellView_2.titleLabel.text = @"FAVORITES";
    _flowMenuView.assignInfoView.assignCellView_3.titleLabel.text = @"VIEWS";
}

- (void)initSetDataArray
{
    _dataModelArray = [NSMutableArray new];
    
    [self addModel_NightLife];
    [self addModel_ArtCulture];
    [self addModel_FoodFestivals];
    [self addModel_NightLife];
    [self addModel_ArtCulture];
    [self addModel_FoodFestivals];
}

#define redDark     UIColorFromHEX(0xcb5558)
#define red         UIColorFromHEX(0xd45d6e)
#define redLight    UIColorFromHEX(0xd7637e)

- (void)addModel_NightLife
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr           = @"Night life";
    tempModel.imageNameStr      = @"wine";
    tempModel.followersNum      = @"517";
    tempModel.favoritesNum      = @"315";
    tempModel.viewsNum          = @"7815";
    tempModel.myColor_dark      = UIColorFromHEX(0xcb5558);
    tempModel.myColor_normal    = UIColorFromHEX(0xd45d6e);
    tempModel.myColor_light     = UIColorFromHEX(0xd7637e);
    [_dataModelArray addObject:tempModel];
}

- (void)addModel_ArtCulture
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr           = @"Art & Culture";
    tempModel.imageNameStr      = @"art";
    tempModel.followersNum      = @"437";
    tempModel.favoritesNum      = @"526";
    tempModel.viewsNum          = @"8361";
    tempModel.myColor_dark      = UIColorFromHEX(0x5abca7);
    tempModel.myColor_normal    = UIColorFromHEX(0x61cab4);
    tempModel.myColor_light     = UIColorFromHEX(0x66d3bc);
    [_dataModelArray addObject:tempModel];
}

- (void)addModel_FoodFestivals
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr           = @"Foot festivals";
    tempModel.imageNameStr      = @"food";
    tempModel.followersNum      = @"472";
    tempModel.favoritesNum      = @"214";
    tempModel.viewsNum          = @"2741";
    tempModel.myColor_dark      = UIColorFromHEX(0xb752eb);
    tempModel.myColor_normal    = UIColorFromHEX(0xc165f0);
    tempModel.myColor_light     = UIColorFromHEX(0xc873f4);
    [_dataModelArray addObject:tempModel];
}



#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataModelArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.0 / 372 * WIDTH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    
    //  此处暂时不用复用机制
//    FlowMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[FlowMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    
    FlowMenuViewCell *cell = [[FlowMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:cellID
                                                       withDataModel:_dataModelArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
