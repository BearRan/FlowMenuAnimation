//
//  AppDelegate.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

static BOOL showAssistantPoint  = NO;   //显示辅助点
static BOOL showPath            = NO;   //显示路径
static BOOL showPathBgViewColor = NO;   //显示路径层的背景色
static BOOL flowViewClipBounds  = YES;  //主view clipBounds
static BOOL needDragGesture     = NO;   //是否需要拖动手势
static BOOL showSingleFlowDemo  = NO;  //只显示一个demo view

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

