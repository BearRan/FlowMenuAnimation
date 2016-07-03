//
//  ArrowAnimationView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ArrowAnimationView.h"

static CGFloat animationDuring = 1.0;

@interface ArrowAnimationView ()
{
    UIView  *_pointVL;
    UIView  *_pointVC;
    UIView  *_pointVR;
    
    CGPoint _pointL_open;
    CGPoint _pointC_open;
    CGPoint _pointR_open;
    
    CGPoint _pointL_close;
    CGPoint _pointC_close;
    CGPoint _pointR_close;
}

@end

@implementation ArrowAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createPoint];
    }
    
    return self;
}

- (void)createPoint
{
    _pointL_open = CGPointMake(0, 0);
    _pointC_open = CGPointMake(self.width / 2.0, self.height);
    _pointR_open = CGPointMake(self.width, 0);
    
    _pointL_close = CGPointMake(0, self.height);
    _pointC_close = CGPointMake(self.width / 2.0, 0);
    _pointR_close = CGPointMake(self.width, self.height);
    
    _pointVL = [self createSinglePointV:_pointL_open];
    _pointVC = [self createSinglePointV:_pointC_open];
    _pointVR = [self createSinglePointV:_pointR_open];
}

- (UIView *)createSinglePointV:(CGPoint)center
{
    UIView *tempPointV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    tempPointV.center = center;
    tempPointV.backgroundColor = [UIColor whiteColor];
    [self addSubview:tempPointV];
    
    return tempPointV;
}

@synthesize open = _open;
- (void)setOpen:(BOOL)open
{
    _open = open;
    
    if (open == YES) {
        [UIView animateWithDuration:animationDuring animations:^{
            _pointVL.center = _pointL_open;
            _pointVC.center = _pointC_open;
            _pointVR.center = _pointR_open;
        }];
    }else{
        [UIView animateWithDuration:animationDuring animations:^{
            _pointVL.center = _pointL_close;
            _pointVC.center = _pointC_close;
            _pointVR.center = _pointR_close;
        }];
    }
}

@end
