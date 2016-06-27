//
//  BearAlertView.h
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BearAlertBtnsView.h"

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


typedef void (^kAlertViewBlock)();
typedef void (^AnimationFinishBlock)();
typedef void (^AnimationClose_FinishBlock)();


@interface BearAlertView : UIView

@property (assign, nonatomic) BOOL tapBgCancel; //触摸背景，消失Alert
@property (copy, nonatomic) AnimationClose_FinishBlock  animationClose_FinishBlock; //消退动画完成block

/**
 *  设置contentView
 */
- (void)setContentView:(UIView *)contentView;

/**
 *  设置btnsView
 */
- (void)setBtnsView:(BearAlertBtnsView *)btnsView;

/**
 *  点击按钮block
 *
 *  @param confirmBlock 确认按钮block
 *  @param cancelBlock  取消按钮block
 */
- (void)alertView_ConfirmClickBlock:(kAlertViewBlock)confirmBlock CancelClickBlock:(kAlertViewBlock)cancelBlock;

/**
 *  点击按钮block
 *
 *  @param selectBtn 点击的按钮
 *  @param block     按钮block
 */
- (void)alertView_SelectBtn:(UIButton *)selectBtn block:(kAlertViewBlock)block;

/**
 *  消失
 */
- (void)dismiss;

@end
