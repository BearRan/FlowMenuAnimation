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
#import "AssignPointModel.h"

@interface FlowMenuView ()
{
    CGPoint _controlPoint_1;
    CGPoint _controlPoint_2;
    CGPoint startPoint;
    CGPoint endPoint;
    
    UIBezierPath    *_bezierPath_downGroove;
    CAShapeLayer    *_grooveBgLayer;
    UIView          *_grooveBgView;
    
    CADisplayLink *_displayLink;
    
    UIButton    *_startBtn;
    BOOL        _showGrooveLayer;
    
    ButtonsView *_buttonsView;
    AssignPointModel *_assignPointModel;
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
    
    
    //  初始化控制点
    
    UIView *myView = self;
    CGPoint _point_A    = [self setPoint:201.77 y:0];
    CGPoint _point_B1   = [self setPoint:379.3 y:63.23];
    CGPoint _point_B2   = [self setPoint:201.77 y:0];
    CGPoint _point_B3   = [self setPoint:283.29 y:-7.89];
    CGPoint _point_C1   = [self setPoint:658.03 y:386.82];
    CGPoint _point_C2   = [self setPoint:469.15 y:129.79];
    CGPoint _point_C3   = [self setPoint:529.51 y:342.64];
    CGPoint _point_D1   = [self setPoint:894.83 y:323.41];
    CGPoint _point_D2   = [self setPoint:786.55 y:431];
    CGPoint _point_D3   = [self setPoint:894.83 y:323.41];
    
    _assignPointModel = [AssignPointModel new];
    _assignPointModel._controlPointView_A = [AssignPointView normalPointView_inView:myView finalPoint:_point_A];
    _assignPointModel._controlPointView_B1 = [AssignPointView normalPointView_inView:myView finalPoint:_point_B1];
    _assignPointModel._controlPointView_B2 = [AssignPointView normalPointView_inView:myView finalPoint:_point_B2];
    _assignPointModel._controlPointView_B3 = [AssignPointView normalPointView_inView:myView finalPoint:_point_B3];
    _assignPointModel._controlPointView_C1 = [AssignPointView normalPointView_inView:myView finalPoint:_point_C1];
    _assignPointModel._controlPointView_C2 = [AssignPointView normalPointView_inView:myView finalPoint:_point_C2];
    _assignPointModel._controlPointView_C3 = [AssignPointView normalPointView_inView:myView finalPoint:_point_C3];
    _assignPointModel._controlPointView_D1 = [AssignPointView normalPointView_inView:myView finalPoint:_point_D1];
    _assignPointModel._controlPointView_D2 = [AssignPointView normalPointView_inView:myView finalPoint:_point_D2];
    _assignPointModel._controlPointView_D3 = [AssignPointView normalPointView_inView:myView finalPoint:_point_D3];
    
    _assignPointModel._controlPointView_LeftUp = [AssignPointView normalPointView_inView:myView onlyPoint:CGPointMake(0, 0)];
    _assignPointModel._controlPointView_RightUp = [AssignPointView normalPointView_inView:myView onlyPoint:CGPointMake(self.width, 0)];
    

    //  初始化贝塞尔曲线
    [self updateGrooveLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateGrooveLayer)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self initSetButtonsView];
    
    
    //  开始按钮
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 50, 50, 50)];
    [_startBtn setTitle:@"click" forState:UIControlStateNormal];
    _startBtn.backgroundColor = [UIColor orangeColor];
    [_startBtn addTarget:self action:@selector(startBtn_Event) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
}

- (CGPoint)setPoint:(CGFloat)x y:(CGFloat)y
{
    CGFloat reffer_width = 896;
    CGFloat reffer_height = 483;
    
    CGPoint returnPoint = CGPointMake(1.0 * x / reffer_width * self.width, 1.0 * y / reffer_height * self.height);
    return returnPoint;
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
    [UIView animateWithDuration:1.0 animations:^{
        
        [_assignPointModel._controlPointView_A setCenter_final];
        [_assignPointModel._controlPointView_B1 setCenter_final];
        [_assignPointModel._controlPointView_B2 setCenter_final];
        [_assignPointModel._controlPointView_B3 setCenter_final];
        [_assignPointModel._controlPointView_C1 setCenter_final];
        [_assignPointModel._controlPointView_C2 setCenter_final];
        [_assignPointModel._controlPointView_C3 setCenter_final];
        [_assignPointModel._controlPointView_D1 setCenter_final];
        [_assignPointModel._controlPointView_D2 setCenter_final];
        [_assignPointModel._controlPointView_D3 setCenter_final];
        
    }completion:^(BOOL finished) {
        _buttonsView.beizerPath = _bezierPath_downGroove;
        [_buttonsView showBtnsAnimation];
    }];
}

- (void)closeGrooveAniamtion
{
    [UIView animateWithDuration:1.0 animations:^{
        
        [_assignPointModel._controlPointView_A setCenter_start];
        [_assignPointModel._controlPointView_B1 setCenter_start];
        [_assignPointModel._controlPointView_B2 setCenter_start];
        [_assignPointModel._controlPointView_B3 setCenter_start];
        [_assignPointModel._controlPointView_C1 setCenter_start];
        [_assignPointModel._controlPointView_C2 setCenter_start];
        [_assignPointModel._controlPointView_C3 setCenter_start];
        [_assignPointModel._controlPointView_D1 setCenter_start];
        [_assignPointModel._controlPointView_D2 setCenter_start];
        [_assignPointModel._controlPointView_D3 setCenter_start];

    }];
}


#pragma mark - 更新沟槽图层

- (void)updateGrooveLayer
{
    if (!_bezierPath_downGroove) {
        _bezierPath_downGroove = [UIBezierPath bezierPath];
    }
    
    if (!_grooveBgLayer) {
        _grooveBgLayer = [CAShapeLayer layer];
        BOOL showFillColor = YES;
        if (showFillColor) {
            _grooveBgLayer.fillColor = UIColorFromHEX(0xe6425f).CGColor;
        }else{
            _grooveBgLayer.fillColor = [UIColor clearColor].CGColor;
            _grooveBgLayer.strokeColor = [UIColor greenColor].CGColor;
            _grooveBgLayer.lineWidth = 2.0;
        }
    }
    
    
    [_bezierPath_downGroove removeAllPoints];
    _bezierPath_downGroove = UIBezierPath.bezierPath;
    [_bezierPath_downGroove moveToPoint: _assignPointModel._controlPointView_LeftUp.prePosition];
    [_bezierPath_downGroove addLineToPoint: _assignPointModel._controlPointView_A.prePosition];
    [_bezierPath_downGroove addCurveToPoint: _assignPointModel._controlPointView_B1.prePosition
                              controlPoint1: _assignPointModel._controlPointView_B2.prePosition
                              controlPoint2: _assignPointModel._controlPointView_B3.prePosition];
    [_bezierPath_downGroove addCurveToPoint: _assignPointModel._controlPointView_C1.prePosition
                              controlPoint1: _assignPointModel._controlPointView_C2.prePosition
                              controlPoint2: _assignPointModel._controlPointView_C3.prePosition];
    [_bezierPath_downGroove addCurveToPoint: _assignPointModel._controlPointView_D1.prePosition
                              controlPoint1: _assignPointModel._controlPointView_D2.prePosition
                              controlPoint2: _assignPointModel._controlPointView_D3.prePosition];
    
    [_bezierPath_downGroove addLineToPoint:_assignPointModel._controlPointView_RightUp.prePosition];
    [_bezierPath_downGroove closePath];

    
    _grooveBgLayer.path = _bezierPath_downGroove.CGPath;
    [self.layer addSublayer:_grooveBgLayer];
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








