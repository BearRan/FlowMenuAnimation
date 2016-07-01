//
//  ViewController.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "FlowMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI
{
    CGFloat width = WIDTH;
    CGFloat height = 198.0 / 372 * width;
    FlowMenuView *flowMenuView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:flowMenuView];
    
    [flowMenuView BearSetCenterToParentViewWithAxis:kAXIS_Y];
    [flowMenuView setY:flowMenuView.y + 200];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
