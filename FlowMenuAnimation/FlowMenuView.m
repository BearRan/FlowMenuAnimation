//
//  FlowMenuView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/22.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "FlowMenuView.h"
#import "AssignPointView.h"
#import "ButtonsView.h"
#import "SpecialBtn.h"

@interface FlowMenuView ()
{
    CGPoint _controlPoint_1;
    CGPoint _controlPoint_2;
    CGPoint startPoint;
    CGPoint endPoint;
    
    AssignPointView *_controlPointView_1;
    AssignPointView *_controlPointView_2;
    AssignPointView *_controlPointView_start;
    AssignPointView *_controlPointView_end;
    
    UIBezierPath    *_bezierPath_downGroove;
    UIBezierPath    *_bezierPath_grooveBg;
    CAShapeLayer    *_grooveBgLayer;
    UIView          *_grooveBgView;
    
    CADisplayLink *_displayLink;
    
    UIButton    *_startBtn;
    BOOL        _showGrooveLayer;
    
    ButtonsView *_buttonsView;
}

@end

@implementation FlowMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor blueColor];
        _showGrooveLayer = NO;
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    _grooveBgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_grooveBgView];
    
    //  沟槽的四个Bezier控制点
    
    startPoint = CGPointMake(100.0 / 372 * self.width, 0);
    _controlPointView_start = [AssignPointView normalPointView];
    _controlPointView_start.center = startPoint;
    [_grooveBgView addSubview:_controlPointView_start];
    
    endPoint = CGPointMake(self.width * 1.4, 0);
    _controlPointView_end = [AssignPointView normalPointView];
    _controlPointView_end.center = endPoint;
    [_grooveBgView addSubview:_controlPointView_end];
    
    CGFloat controlPointView_1_x = 291.0 / 372 * self.width;
    CGFloat controlPointView_1_y = 10;
    _controlPoint_1 = CGPointMake(controlPointView_1_x, controlPointView_1_y);
    _controlPointView_1 = [AssignPointView normalPointView];
    _controlPointView_1.center = _controlPoint_1;
    [_grooveBgView addSubview:_controlPointView_1];
    
    CGFloat controlPointView_2_x = 184.0 / 372 * self.width;
    CGFloat controlPointView_2_y = 274;
    _controlPoint_2 = CGPointMake(controlPointView_2_x, controlPointView_2_y);
    _controlPointView_2 = [AssignPointView normalPointView];
    _controlPointView_2.center = _controlPoint_2;
    [_grooveBgView addSubview:_controlPointView_2];
    
    
    
    //  初始化沟槽的Bezier曲线
    
    _bezierPath_downGroove = [UIBezierPath bezierPath];
    [_bezierPath_downGroove moveToPoint:CGPointMake(0, 0)];
    [_bezierPath_downGroove addLineToPoint:startPoint];
    [_bezierPath_downGroove addCurveToPoint:endPoint controlPoint1:_controlPointView_1.layer.position controlPoint2:_controlPointView_2.layer.position];
    
    _bezierPath_grooveBg = [UIBezierPath bezierPath];
    [_bezierPath_grooveBg appendPath:_bezierPath_downGroove];
    [_bezierPath_grooveBg addLineToPoint:CGPointMake(0, 0)];
    [_bezierPath_grooveBg closePath];
    
    _grooveBgLayer = [CAShapeLayer layer];
    _grooveBgLayer.path = _bezierPath_grooveBg.CGPath;
    _grooveBgLayer.fillColor = UIColorFromHEX(0xe6425f).CGColor;
    [_grooveBgView.layer addSublayer:_grooveBgLayer];
    
    
    [_grooveBgView bringSubviewToFront:_controlPointView_1];
    [_grooveBgView bringSubviewToFront:_controlPointView_2];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateGrooveBgLayer)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self initSetButtonsView];
    
    
    //  开始按钮
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 50, 50, 50)];
    [_startBtn setTitle:@"click" forState:UIControlStateNormal];
    _startBtn.backgroundColor = [UIColor orangeColor];
    [_startBtn addTarget:self action:@selector(startBtn_Event) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
}


//  初始化设置buttonsView
- (void)initSetButtonsView
{
    CGFloat btn_width = 40;
    NSMutableArray *btnsArray = [NSMutableArray new];
    
    SpecialBtn *btn_1 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_1.layer.cornerRadius = btn_1.width / 2.0;
    btn_1.backgroundColor = [UIColor purpleColor];
    [btnsArray addObject:btn_1];
    
    SpecialBtn *btn_2 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_2.layer.cornerRadius = btn_2.width / 2.0;
    btn_2.backgroundColor = [UIColor grayColor];
    [btnsArray addObject:btn_2];
    
    SpecialBtn *btn_3 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_3.layer.cornerRadius = btn_3.width / 2.0;
    btn_3.backgroundColor = [UIColor greenColor];
    [btnsArray addObject:btn_3];
    
    _buttonsView = [[ButtonsView alloc] initWithFrame:self.bounds btnsArray:btnsArray];
    [self addSubview:_buttonsView];
}


#pragma mark - 显示／关闭沟槽动画

- (void)showGrooveAniamtion
{
    _controlPointView_1.center = CGPointMake(_controlPoint_1.x, 0);
    _controlPointView_2.center = CGPointMake(_controlPoint_2.x, 0);
    [UIView animateWithDuration:1.0 animations:^{
        _controlPointView_1.center = _controlPoint_1;
        _controlPointView_2.center = _controlPoint_2;
    }completion:^(BOOL finished) {
        _buttonsView.beizerPath = _bezierPath_downGroove;
        [_buttonsView showBtnsAnimation];
    }];
}

- (void)closeGrooveAniamtion
{
    _controlPointView_1.center = _controlPoint_1;
    _controlPointView_2.center = _controlPoint_2;
    [UIView animateWithDuration:1.0 animations:^{
        _controlPointView_1.center = CGPointMake(_controlPoint_1.x, 0);
        _controlPointView_2.center = CGPointMake(_controlPoint_2.x, 0);
    }];
}


#pragma mark - 更新沟槽图层

- (void)updateGrooveBgLayer
{
    CALayer *presentLayer_1 = _controlPointView_1.layer.presentationLayer;
    CALayer *presentLayer_2 = _controlPointView_2.layer.presentationLayer;
    
    
    [_bezierPath_downGroove removeAllPoints];
    [_bezierPath_downGroove moveToPoint:CGPointMake(0, 0)];
    [_bezierPath_downGroove addLineToPoint:startPoint];
    [_bezierPath_downGroove addCurveToPoint:endPoint controlPoint1:presentLayer_1.position controlPoint2:presentLayer_2.position];
    
    [_bezierPath_grooveBg removeAllPoints];
    [_bezierPath_grooveBg appendPath:_bezierPath_downGroove];
    [_bezierPath_grooveBg addLineToPoint:CGPointMake(0, 0)];
    [_bezierPath_grooveBg closePath];
    
    _grooveBgLayer.path = _bezierPath_grooveBg.CGPath;
    [self.layer addSublayer:_grooveBgLayer];
    
    [self bringSubviewToFront:_controlPointView_1];
    [self bringSubviewToFront:_controlPointView_2];
}


#pragma mark - btnClick

- (void)startBtn_Event
{
    _showGrooveLayer = !_showGrooveLayer;
    
    if (_showGrooveLayer) {
        [self showGrooveAniamtion];
    }else{
        [self closeGrooveAniamtion];
    }
}

@end








