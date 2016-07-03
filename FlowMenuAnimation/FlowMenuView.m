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
#import "UIView+SetSize.h"
#import "StartBtn.h"

static CGFloat moveInfoView_AnimationDuring = 0.3;
static CGFloat grooveLayer_AnimationDuring = 0.5;

@interface FlowMenuView ()
{
    UIBezierPath    *_bezierPath_downGroove;
    CAShapeLayer    *_grooveBgLayer;
    UIView          *_grooveBgView;
    
    CADisplayLink   *_displayLink;
    BOOL            _showGrooveLayer;
    
    ButtonsView         *_buttonsView;
    AssignPointModel    *_assignPointModel;
    CellDataModel       *_dataModel;
}

@property (strong, nonatomic) StartBtn    *startBtn;

@end


@implementation FlowMenuView

- (instancetype)initWithFrame:(CGRect)frame withDataModel:(CellDataModel *)dataModel
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        if (flowViewClipBounds) {
            self.clipsToBounds = YES;
        }
        
        self.backgroundColor = dataModel.myColor_light;
        _showGrooveLayer = NO;
        _dataModel = dataModel;
        
        [self createInfoView];
        [self createUI];
    }
    
    return self;
}

- (void)createInfoView
{
    _mainInfoView = [[MainInfoView alloc] initWithFrame:CGRectMake(0, self.height * 0.32, self.width, 40)];
    _mainInfoView.backgroundColor = [UIColor clearColor];
    [self addSubview:_mainInfoView];
    
    _assignInfoView = [[AssignInfoView alloc] initWithFrame:CGRectMake(0, _mainInfoView.maxY + self.height * 0.05, self.width, 50)];
    _assignInfoView.backgroundColor = [UIColor clearColor];
    [self addSubview:_assignInfoView];
}

- (void)createUI
{
    _grooveBgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_grooveBgView];
    
    //  初始化控制点
    
    CGFloat offScreen_x = 100;  //超屏距离
    UIView *myView = self;
    CGPoint _point_0    = [self setPoint:-offScreen_x y:0];
    CGPoint _point_A    = [self setPoint:201.77 y:1.02];
    CGPoint _point_B1   = [self setPoint:379.3 y:64.23];
    CGPoint _point_B2   = [self setPoint:201.77 y:1.02];
    CGPoint _point_B3   = [self setPoint:279.69 y:-6.26];
    CGPoint _point_C1   = [self setPoint:658.03 y:387.82];
    CGPoint _point_C2   = [self setPoint:481.08 y:136.27];
    CGPoint _point_C3   = [self setPoint:530.1 y:350.79];
    CGPoint _point_D1   = [self setPoint:1068.9 y:29.54];
    CGPoint _point_D2   = [self setPoint:931.82 y:467.08];
    CGPoint _point_D3   = [self setPoint:1068.9 y:29.54];
    
    _assignPointModel = [AssignPointModel new];
    _assignPointModel._controlPointView_0 = [AssignPointView normalPointView_inView:myView finalPoint:_point_0];
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
    
    _assignPointModel._controlPointView_LeftUp = [AssignPointView normalPointView_inView:myView onlyPoint:CGPointMake(-offScreen_x, 0)];
    _assignPointModel._controlPointView_RightUp = [AssignPointView normalPointView_inView:myView onlyPoint:CGPointMake(self.width + offScreen_x, 0)];
    

    //  初始化贝塞尔曲线
    [self updateGrooveLayer];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateGrooveLayer)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
    
    
    //  开始按钮
    CGFloat btn_width = [self setXX:172];
    _startBtn = [[StartBtn alloc] initWithFrame:CGRectMake(self.width - btn_width, 0, btn_width, btn_width) withDataModel:_dataModel];
    [_startBtn addTarget:self action:@selector(startBtn_Event) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startBtn];
}

//  初始化设置buttonsView
- (void)initSetButtonsView
{
    CGFloat btn_width = 46;
    NSMutableArray *btnsArray = [NSMutableArray new];
    
    SpecialBtn *btn_1 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_1.layer.cornerRadius = btn_1.width / 2.0;
    btn_1.layer.masksToBounds = YES;
    btn_1.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    [btn_1 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    btn_1.backgroundColor = [UIColor whiteColor];
    [btnsArray addObject:btn_1];
    
    SpecialBtn *btn_2 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_2.layer.cornerRadius = btn_2.width / 2.0;
    btn_2.layer.masksToBounds = YES;
    btn_2.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    [btn_2 setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    btn_2.backgroundColor = [UIColor whiteColor];
    [btnsArray addObject:btn_2];
    
    SpecialBtn *btn_3 = [[SpecialBtn alloc] initWithFrame:CGRectMake(0, 0, btn_width, btn_width)];
    btn_3.layer.cornerRadius = btn_3.width / 2.0;
    btn_3.layer.masksToBounds = YES;
    btn_3.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    [btn_3 setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    btn_3.backgroundColor = [UIColor whiteColor];
    [btnsArray addObject:btn_3];
    
    __weak __typeof__(self) weakSelf = self;
    _buttonsView = [[ButtonsView alloc] initWithFrame:self.bounds btnsArray:btnsArray];
    _buttonsView.hidden = YES;
    _buttonsView.dynamicAnimaionCloseFinsh = ^(){
        NSLog(@"--_buttonsView.dynamicAnimaionCloseFinsh");
        [weakSelf closeGrooveAniamtion];
        [weakSelf moveCenterInfoViewAniamtion];
    };
    _buttonsView.dynamicAnimaionShowFinsh = ^(){
        weakSelf.startBtn.enabled = YES;
    };
    [self addSubview:_buttonsView];
}

#pragma mark - 左移／复位InfoView

- (void)moveLeftInfoViewAniamtion
{
    [UIView animateWithDuration:moveInfoView_AnimationDuring
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.mainInfoView setCenterX:0];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
    
    [UIView animateWithDuration:moveInfoView_AnimationDuring
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.assignInfoView setCenterX:0];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

- (void)moveCenterInfoViewAniamtion
{
    CGFloat delayTime = 0.3;
    
    [UIView animateWithDuration:moveInfoView_AnimationDuring
                          delay:delayTime
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.mainInfoView BearSetCenterToParentViewWithAxis:kAXIS_X];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
    
    [UIView animateWithDuration:moveInfoView_AnimationDuring
                          delay:delayTime
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.assignInfoView BearSetCenterToParentViewWithAxis:kAXIS_X];
                     } completion:^(BOOL finished) {
                         nil;
                     }];
}

#pragma mark - 显示／关闭沟槽动画

- (void)showGrooveAniamtion
{
    _displayLink.paused = NO;
    [UIView animateWithDuration:grooveLayer_AnimationDuring animations:^{
        
        [_assignPointModel._controlPointView_0 setCenter_final];
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
        
        _displayLink.paused = YES;
        
        [self initSetButtonsView];
        [self bringSubviewToFront:_buttonsView];
        [self bringSubviewToFront:_startBtn];
        _buttonsView.hidden = NO;
        _buttonsView.beizerPath = _bezierPath_downGroove;
        [_buttonsView showBtnsAnimation];
    }];
}

- (void)closeGrooveAniamtion
{
    _displayLink.paused = NO;
    [UIView animateWithDuration:grooveLayer_AnimationDuring animations:^{
        
        [_assignPointModel._controlPointView_0 setCenter_start];
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

    }completion:^(BOOL finished) {
        _displayLink.paused = YES;
        _buttonsView.hidden = YES;
        [_buttonsView removeFromSuperview];
        _buttonsView = nil;
        _startBtn.enabled = YES;
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
            _grooveBgLayer.fillColor = _dataModel.myColor_normal.CGColor;
        }else{
            _grooveBgLayer.fillColor = [UIColor clearColor].CGColor;
            _grooveBgLayer.strokeColor = [UIColor greenColor].CGColor;
            _grooveBgLayer.lineWidth = 2.0;
        }
    }
    
    
    [_bezierPath_downGroove removeAllPoints];
    _bezierPath_downGroove = UIBezierPath.bezierPath;
    [_bezierPath_downGroove moveToPoint: _assignPointModel._controlPointView_0.prePosition];
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
    [_bezierPath_downGroove addLineToPoint:_assignPointModel._controlPointView_LeftUp.prePosition];
    [_bezierPath_downGroove closePath];

    
    _grooveBgLayer.path = _bezierPath_downGroove.CGPath;
    [_grooveBgView.layer addSublayer:_grooveBgLayer];
}


#pragma mark - btnClick

- (void)startBtn_Event
{
    _showGrooveLayer = !_showGrooveLayer;
    _startBtn.selected = _showGrooveLayer;
    _startBtn.enabled = NO;
    
    if (_showGrooveLayer) {
        NSLog(@"--1");
        [self showGrooveAniamtion];
        [self moveLeftInfoViewAniamtion];
        
    }else{
        NSLog(@"--2");
        [_buttonsView closeBtnsAniamtion];
    }
}

@end








