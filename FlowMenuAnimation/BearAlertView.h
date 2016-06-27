//
//  BearAlertView.h
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>

//  动效方式
typedef enum {
    kAlertViewAnimation_VerticalSpring,     //直线弹簧动效
    kAlertViewAnimation_CenterScale,        //中心缩放动效
}AlertViewAnimation;

//  动画执行状态
typedef enum {
    kAlertViewAnimationState_Null,          //无状态，
    kAlertViewAnimationState_Process,       //动画进行中
}AlertViewAnimationState;


typedef void (^kUDAlertViewBlock)();
typedef void (^AnimationFinishBlock)();
typedef void (^AnimationClose_FinishBlock)();


@interface BearAlertView : UIView

@property (assign, nonatomic) BOOL tapBgCancel; //触摸背景，消失Alert
@property (copy, nonatomic) AnimationClose_FinishBlock  animationClose_FinishBlock; //消退动画完成block

- (void)udAlertView_ConfirmClickBlock:(kUDAlertViewBlock)confirmBlock CancelClickBlock:(kUDAlertViewBlock)cancelBlock;

/**
 *  消失
 */
- (void)dismiss;

/**
 *  添加按钮点击事件
 */
- (void)btnEvent:(UIButton *)sender;

@end
