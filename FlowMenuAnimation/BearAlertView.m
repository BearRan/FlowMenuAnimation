//
//  BearAlertView.m
//  GOSHOPPING
//
//  Created by Bear on 16/6/26.
//  Copyright © 2016年 cjl. All rights reserved.
//

#import "BearAlertView.h"
#import <objc/runtime.h>
#import "BearAlertBtnsView.h"
#import "BearAlertContentView.h"

static const char *const kUDAlertViewBlockKey = "UDAlertViewBlockKey";

static NSString *kAnimationKey_ShowUDAlertView = @"AnimationKey_ShowUDAlertView";
static NSString *kAnimationKey_CloseUDAlertView = @"AnimationKey_CloseUDAlertView";
static NSString *kAnimationKey_HideBgView = @"AnimationKey_HideBgView";
static NSString *kAnimationKey_ShowBgView = @"AnimationKey_ShowBgView";
static NSString *kAnimationKey_ShowUDAlertViewScale = @"AnimationKey_ShowUDAlertViewScale";


@interface BearAlertView () <UIApplicationDelegate>
{
    CGFloat _button_height;
}
@property (strong, nonatomic) UIView        *bgView;
@property (strong, nonatomic) UIView        *udAlertView;

@property (strong, nonatomic) BearAlertContentView *alertContentView;
@property (strong, nonatomic) BearAlertBtnsView *alertBtnsView;

@property (assign, nonatomic) AlertViewAnimation    alertViewAnimation;
@property (copy, nonatomic)   AnimationFinishBlock  animationFinishBlock;
@property (assign, nonatomic) AlertViewAnimationState alertViewAnimationState;

@end

@implementation BearAlertView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _alertViewAnimation = kAlertViewAnimation_VerticalSpring;
        _tapBgCancel = YES;
        _button_height = 74;
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    //  背景蒙板View
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self addSubview:_bgView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedDismiss)];
    tapGesture.numberOfTapsRequired = 1;
    [_bgView addGestureRecognizer:tapGesture];
    
    //  AlertView
    _udAlertView = [[UIView alloc] init];
    _udAlertView.backgroundColor = [UIColor whiteColor];
    _udAlertView.layer.cornerRadius = 9.0f;
    _udAlertView.layer.masksToBounds = YES;
    [_bgView addSubview:_udAlertView];
    
    //  _contentView
    _alertContentView = [[BearAlertContentView alloc] init];
    _alertContentView.titleLabel.text = @"请输入一个标题";
    _alertContentView.contentLabel.text = @"请输入正文内容!!!请输入正文内容!!!";
    [_udAlertView addSubview:_alertContentView];
    
    //  _alertBtnsView
    _alertBtnsView = [[BearAlertBtnsView alloc] init];
    [_alertBtnsView setNormal_ConfirmBtnTitle:@"取消" CancelBtnTitle:@"确认"];
    [_udAlertView addSubview:_alertBtnsView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_alertContentView layoutSubviews];
    
    _alertBtnsView.frame = CGRectMake(0, _alertContentView.maxY, _alertContentView.width, 35);
    [_alertBtnsView layoutSubviews];
    
    _udAlertView.size = CGSizeMake(_alertContentView.width, _alertBtnsView.maxY);
    [_udAlertView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
    [self animationShow_udAlertView];
}




#pragma mark 动画处理

- (void)animationShow_udAlertView
{
    
    if (_alertViewAnimationState == kAlertViewAnimationState_Process) {
        return;
    }
    
    _alertViewAnimationState = kAlertViewAnimationState_Process;
    
    CGFloat animationTime_bgAlpha = 0.3;
    CGFloat animationTime_keyShow = 0.5;
    
    
    //  背景透明度
    CABasicAnimation *basicAnimation_bgAlpha = [CABasicAnimation animation];
    basicAnimation_bgAlpha.delegate = self;
    basicAnimation_bgAlpha.keyPath = @"opacity";
    basicAnimation_bgAlpha.duration = animationTime_bgAlpha;
    basicAnimation_bgAlpha.fromValue = [NSNumber numberWithFloat:0.0f];
    basicAnimation_bgAlpha.toValue = [NSNumber numberWithFloat:1.0f];
    basicAnimation_bgAlpha.removedOnCompletion = NO;
    [_bgView.layer addAnimation:basicAnimation_bgAlpha forKey:kAnimationKey_ShowBgView];
    
    
    switch (_alertViewAnimation) {
            
        case kAlertViewAnimation_VerticalSpring:
        {
            //  出现路径
            [_udAlertView setCenter:CGPointMake(_bgView.width/2.0, -_udAlertView.height/2.0)];
            [UIView animateWithDuration:animationTime_keyShow
                                  delay:animationTime_bgAlpha
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.7
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [_udAlertView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
                             }
                             completion:^(BOOL finished) {
                                 _alertViewAnimationState = kAlertViewAnimationState_Null;
                             }];
        }
            break;
            
        case kAlertViewAnimation_CenterScale:
        {
            //  出现路径
            _udAlertView.hidden = YES;
            [_udAlertView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
            keyFrameAnimation.delegate = self;
            keyFrameAnimation.keyPath = @"transform.scale";
            NSArray *array_my = @[@0.2, @1.1, @0.9, @1.0];
            keyFrameAnimation.values = array_my;
            keyFrameAnimation.duration = animationTime_keyShow;
            keyFrameAnimation.beginTime = CACurrentMediaTime() + animationTime_bgAlpha;
            keyFrameAnimation.removedOnCompletion = NO;
            keyFrameAnimation.fillMode = kCAFillModeForwards;
            [_udAlertView.layer addAnimation:keyFrameAnimation forKey:kAnimationKey_ShowUDAlertViewScale];
        }
            
        default:
            break;
    }
    
}

- (void)animationClose_udAlertView
{
    if (_alertViewAnimationState == kAlertViewAnimationState_Process) {
        return;
    }
    
    _alertViewAnimationState = kAlertViewAnimationState_Process;
    
    CGFloat animationTime_keyClose = 0.3;
    CGFloat animationTime_bgAlpha = 0.3;
    
    switch (_alertViewAnimation) {
            
        case kAlertViewAnimation_VerticalSpring:
        {
            
        }
            break;
            
        case kAlertViewAnimation_CenterScale:
        {
            
        }
            
        default:
            break;
    }
    
    //  消失路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(_bgView.width/2.0, _bgView.height/2.0)];
    [bezierPath addLineToPoint:CGPointMake(_bgView.width/2.0, _bgView.height + _udAlertView.height)];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.keyPath = @"position";
    keyFrameAnimation.duration = animationTime_keyClose;
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    [_udAlertView.layer addAnimation:keyFrameAnimation forKey:kAnimationKey_CloseUDAlertView];
    
    
    //  背景透明度
    CABasicAnimation *basicAnimation_bgAlpha = [CABasicAnimation animation];
    basicAnimation_bgAlpha.delegate = self;
    basicAnimation_bgAlpha.keyPath = @"opacity";
    basicAnimation_bgAlpha.duration = animationTime_bgAlpha;
    basicAnimation_bgAlpha.fromValue = [NSNumber numberWithFloat:1.0];
    basicAnimation_bgAlpha.toValue = [NSNumber numberWithFloat:0.0];
    basicAnimation_bgAlpha.beginTime = CACurrentMediaTime() + animationTime_keyClose;
    basicAnimation_bgAlpha.removedOnCompletion = NO;
    basicAnimation_bgAlpha.fillMode = kCAFillModeForwards;
    [_bgView.layer addAnimation:basicAnimation_bgAlpha forKey:kAnimationKey_HideBgView];
}


//  Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[_udAlertView.layer animationForKey:kAnimationKey_ShowUDAlertView]]) {
        
        _alertViewAnimationState = kAlertViewAnimationState_Null;
        
        [_udAlertView BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
        [_udAlertView.layer removeAnimationForKey:kAnimationKey_ShowUDAlertView];
    }
    
    
    else if ([anim isEqual:[_udAlertView.layer animationForKey:kAnimationKey_CloseUDAlertView]]){
        
        [_udAlertView.layer removeAnimationForKey:kAnimationKey_CloseUDAlertView];
        [_udAlertView removeFromSuperview];
    }
    
    
    else if ([anim isEqual:[_bgView.layer animationForKey:kAnimationKey_ShowBgView]]){
        
        [_bgView.layer removeAnimationForKey:kAnimationKey_ShowBgView];
        
        if (_alertViewAnimation == kAlertViewAnimation_CenterScale) {
            _udAlertView.hidden = NO;
        }
        
    }
    
    
    else if ([anim isEqual:[_bgView.layer animationForKey:kAnimationKey_HideBgView]]){
        
        _alertViewAnimationState = kAlertViewAnimationState_Null;
        
        [_bgView.layer removeAnimationForKey:kAnimationKey_HideBgView];
        [_bgView removeFromSuperview];
        [self removeFromSuperview];
        
        if (self.animationFinishBlock) {
            self.animationFinishBlock();
        }
    }
    
    
    else if ([anim isEqual:[_udAlertView.layer animationForKey:kAnimationKey_ShowUDAlertViewScale]]){
        
        _alertViewAnimationState = kAlertViewAnimationState_Null;
        
        [_udAlertView.layer removeAnimationForKey:kAnimationKey_ShowUDAlertViewScale];
    }
    
}




#pragma 按钮处理事件

//  按钮处理事件
- (void)udAlertView_ConfirmBlock:(kUDAlertViewBlock)confirmBlock cancelBlock:(kUDAlertViewBlock)cancelBlock
{
    objc_setAssociatedObject(_alertBtnsView.confirmBtn, kUDAlertViewBlockKey, confirmBlock, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(_alertBtnsView.cancelBtn, kUDAlertViewBlockKey, cancelBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void)btnEvent:(UIButton *)sender
{
    [self dismiss];
    
    kUDAlertViewBlock block = objc_getAssociatedObject(sender, kUDAlertViewBlockKey);
    
    self.animationFinishBlock = ^{
        if (block) {
            block();
        }
    };
}

- (void)dismiss
{
    [self animationClose_udAlertView];
}

- (void)bgTappedDismiss
{
    if (_tapBgCancel) {
        [self dismiss];
    }
}

@end
