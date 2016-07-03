//
//  ArrowAnimationView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ArrowAnimationView.h"

static CGFloat animationDuring = 0.5;

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
    
    UIBezierPath    *_bezierPath;
    CAShapeLayer    *_shapeLayer;
    CADisplayLink   *_displayLink;
    BOOL            _firstLoad;
}

@end

@implementation ArrowAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = NO;
        
        [self createView];
    }
    
    return self;
}

- (void)createView
{
    _firstLoad = YES;
    
    _pointL_open = CGPointMake(0, 0);
    _pointC_open = CGPointMake(self.width / 2.0, self.height);
    _pointR_open = CGPointMake(self.width, 0);
    
    _pointL_close = CGPointMake(0, self.height);
    _pointC_close = CGPointMake(self.width / 2.0, 0);
    _pointR_close = CGPointMake(self.width, self.height);
    
    _pointVL = [self createSinglePointV:_pointL_open];
    _pointVC = [self createSinglePointV:_pointC_open];
    _pointVR = [self createSinglePointV:_pointR_open];
    
    _bezierPath = [UIBezierPath bezierPath];
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    _shapeLayer.lineWidth = 3.0;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_shapeLayer];
    [self updateLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLayer)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
}

- (UIView *)createSinglePointV:(CGPoint)center
{
    UIView *tempPointV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    tempPointV.center = center;
    tempPointV.backgroundColor = [UIColor clearColor];
    [self addSubview:tempPointV];
    
    return tempPointV;
}

//  更新箭头layer
- (void)updateLayer
{
    CAShapeLayer *_pointVL_presentationLayer = _pointVL.layer.presentationLayer;
    CAShapeLayer *_pointVC_presentationLayer = _pointVC.layer.presentationLayer;
    CAShapeLayer *_pointVR_presentationLayer = _pointVR.layer.presentationLayer;
    
    CGPoint _tempCenter_L;
    CGPoint _tempCenter_C;
    CGPoint _tempCenter_R;
    
    if (_firstLoad == YES) {
        
        _firstLoad = NO;
        
        _tempCenter_L = _pointVL.center;
        _tempCenter_C = _pointVC.center;
        _tempCenter_R = _pointVR.center;
    }else{
        
        _tempCenter_L = _pointVL_presentationLayer.position;
        _tempCenter_C = _pointVC_presentationLayer.position;
        _tempCenter_R = _pointVR_presentationLayer.position;
    }
    
    [_bezierPath removeAllPoints];
    [_bezierPath moveToPoint:_tempCenter_L];
    [_bezierPath addLineToPoint:_tempCenter_C];
    [_bezierPath addLineToPoint:_tempCenter_R];
    
    _shapeLayer.path = _bezierPath.CGPath;
}

@synthesize open = _open;
- (void)setOpen:(BOOL)open
{
    _open = open;
    _displayLink.paused = NO;
    
    if (open == YES) {
        [UIView animateWithDuration:animationDuring animations:^{
            _pointVL.center = _pointL_open;
            _pointVC.center = _pointC_open;
            _pointVR.center = _pointR_open;
        }completion:^(BOOL finished) {
            _displayLink.paused = YES;
        }];
    }
    else{
        [UIView animateWithDuration:animationDuring animations:^{
            _pointVL.center = _pointL_close;
            _pointVC.center = _pointC_close;
            _pointVR.center = _pointR_close;
        }completion:^(BOOL finished) {
            _displayLink.paused = YES;
        }];
    }
}

@end
