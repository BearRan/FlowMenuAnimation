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
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.tableFooterView = [UIView new];
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
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

- (void)addModel_NightLife
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr = @"Night life";
    tempModel.imageNameStr = @"wine";
    tempModel.followersNum = @"517";
    tempModel.favoritesNum = @"315";
    tempModel.viewsNum = @"7815";
    [_dataModelArray addObject:tempModel];
}

- (void)addModel_ArtCulture
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr = @"Art & Culture";
    tempModel.imageNameStr = @"art";
    tempModel.followersNum = @"437";
    tempModel.favoritesNum = @"526";
    tempModel.viewsNum = @"8361";
    [_dataModelArray addObject:tempModel];
}

- (void)addModel_FoodFestivals
{
    CellDataModel *tempModel = [CellDataModel new];
    tempModel.nameStr = @"Foot festivals";
    tempModel.imageNameStr = @"food";
    tempModel.followersNum = @"472";
    tempModel.favoritesNum = @"214";
    tempModel.viewsNum = @"2741";
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
    
    FlowMenuViewCell *cell = [[FlowMenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadData:_dataModelArray[indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
