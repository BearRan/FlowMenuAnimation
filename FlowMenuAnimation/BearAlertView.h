//
//  BearAlertView.h
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BearAlertBtnsView.h"
#import "BearAlertContentView.h"

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

@property (assign, nonatomic)   BOOL clickBtnCancel;         //点击按钮，消失Alert
@property (assign, nonatomic)   BOOL tapBgCancel;           //触摸背景，消失Alert
@property (copy, nonatomic)     AnimationClose_FinishBlock  animationClose_FinishBlock; //消退动画完成block
@property (strong, nonatomic)   BearAlertContentView    *normalAlertContentView;
@property (strong, nonatomic)   BearAlertBtnsView       *normalAlertBtnsView;

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
 *  @notice 只有BearAlertBtnsView类型的btnsView才可使用该方法
 */
- (void)alertView_ConfirmClickBlock:(kAlertViewBlock)confirmBlock CancelClickBlock:(kAlertViewBlock)cancelBlock;

/**
 *  点击按钮block
 *
 *  @param selectBtn 点击的按钮
 *  @param block     按钮block
 *  @notice 自定义，非BearAlertBtnsView类型需要单独给按钮调用该方法
 */
- (void)alertView_SelectBtn:(UIButton *)selectBtn block:(kAlertViewBlock)block;

/**
 *  添加按钮点击事件
 *  @notice 自定义，非BearAlertBtnsView类型需要单独给按钮调用该方法
 */
- (void)btnEvent:(UIButton *)sender;

/**
 *  Alertview显现动画
 */
- (void)animationShow_udAlertView;

/**
 *  AlertView消退动画
 */
- (void)animationClose_udAlertView;

@end
