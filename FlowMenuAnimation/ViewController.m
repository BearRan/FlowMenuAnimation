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
    FlowMenuView *flowMenuView = [[FlowMenuView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    [self.view addSubview:flowMenuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
