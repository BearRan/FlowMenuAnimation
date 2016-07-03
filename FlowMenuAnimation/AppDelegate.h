//
//  AppDelegate.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

#define redDark     UIColorFromHEX(0xcb5558)
#define red         UIColorFromHEX(0xd45d6e)
#define redLight    UIColorFromHEX(0xd7637e)

static BOOL showAssistantPoint  = NO;   //显示辅助点
static BOOL showPath            = YES;   //显示路径
static BOOL showPathBgViewColor = NO;   //显示路径层的背景色
static BOOL flowViewClipBounds  = NO;  //主view clipBounds
static BOOL needDragGesture     = YES;   //是否需要拖动手势

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

