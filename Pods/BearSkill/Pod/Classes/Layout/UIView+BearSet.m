//
//  UIView+BearSet.m
//
//  Created by bear on 15/11/25.
//  Copyright (c) 2015年 Bear. All rights reserved.
//
#import "UIView+BearSet.h"

@implementation UIView (BearSet)


#pragma mark - 界面处理，设置属性，画线的一些方法


//  毛玻璃效果处理
- (void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha
{
    //系统版本
    CGFloat currentDevice = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (currentDevice < 8.0) {
        /*
         iOS7模糊处理
         */
        
        //暂时用背景色处理
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
    }else{
        /*
         iOS8模糊处理
         */
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.alpha = alpha;
        visualEffectView.frame = self.frame;
        [self addSubview:visualEffectView];
    }
}


/**
 *  设置边框
 *
 *  设置边框颜色和宽度
 */
- (void)setMyBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}


/**
 *  自定义分割线View OffY
 *
 *  根据offY在任意位置画横向分割线
 */
- (void)setMySeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY
{
    int parentView_width    = CGRectGetWidth(self.frame);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(offStart, offY, parentView_width - offStart - offEnd, lineWidth)];
    
    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    }else{
        lineView.backgroundColor = lineColor;
    }
    
    [self addSubview:lineView];
}


/**
 *  自定义分底部割线View
 *
 *  自动在底部横向分割线
 */
- (void)setMySeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    CGFloat parentView_height   = CGRectGetHeight(self.frame);
    CGFloat parentView_width    = CGRectGetWidth(self.frame);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(offStart, parentView_height - lineWidth, parentView_width - offStart - offEnd, lineWidth)];
    
    if (!lineColor) {
        lineView.backgroundColor = [UIColor blackColor];
    }else{
        lineView.backgroundColor = lineColor;
    }
    
    [self addSubview:lineView];
}


/**
 *  画线--View
 *
 *  通过view，画任意方向的线
 */
- (void) drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = lineColor;
    
    //竖线
    if (startPoint.x == endPoint.x) {
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, lineWidth, endPoint.y - startPoint.y);
    }
    
    //横线
    else if (startPoint.y == endPoint.y){
        lineView.frame = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, lineWidth);
    }
    
    [self addSubview:lineView];
    
}


/**
 *  画线--Layer
 *
 *  通过layer，画任意方向的线
 *  该方法只能在DrawRect中使用
 */
- (void) drawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor
{
    //1.获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将上下文复制一份到栈中
    CGContextSaveGState(context);
    
    //2.绘制图形
    //设置线段宽度
    CGContextSetLineWidth(context, lineWidth);
    //设置线条头尾部的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //设置颜色
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    
    //设置起点
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    //画线
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    //3.显示到View
    CGContextStrokePath(context);//以空心的方式画出
    
    //将图形上下文出栈，替换当前的上下文
    CGContextRestoreGState(context);
    
    [self setNeedsDisplay];
}






#pragma mark - 布局扩展方法

#pragma mark Getter

//  x
- (CGFloat)x
{
    return self.frame.origin.x;
}

//  y
- (CGFloat)y
{
    return self.frame.origin.y;
}

//  maxX
- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

//  maxY
- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

//  width
- (CGFloat)width
{
    return self.frame.size.width;
}

//  height
- (CGFloat)height
{
    return self.frame.size.height;
}

//  origin
- (CGPoint)origin
{
    return self.frame.origin;
}

//  size
- (CGSize)size
{
    return self.frame.size;
}

//  centerX
- (CGFloat)centerX
{
    return self.center.x;
}

//  centerY
- (CGFloat)centerY
{
    return self.center.y;
}



#pragma mark    Setter

//  setX
- (void)setX:(CGFloat)x
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = x;
    self.frame = tempFrame;
}

//  setMaxX
- (void)setMaxX:(CGFloat)maxX
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = maxX - CGRectGetWidth(self.frame);
    self.frame = tempFrame;
}

//  setMaxX_DontMoveMinX
- (void)setMaxX_DontMoveMinX:(CGFloat)maxX
{
    if (maxX < self.x) {
        NSLog(@"!!! setMaxX_DontMoveMinX: maxX > self.x, 无法布局");
        return;
    }
    [self setWidth:maxX - self.x];
}

//  setY
- (void)setY:(CGFloat)y
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = y;
    self.frame = tempFrame;
}

//  setMaxY
- (void)setMaxY:(CGFloat)maxY
{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = maxY - CGRectGetHeight(self.frame);
    self.frame = tempFrame;
}

//  setMaxY_DontMoveMinY:
- (void)setMaxY_DontMoveMinY:(CGFloat)maxY
{
    if (maxY < self.y) {
        NSLog(@"!!! setMaxY_DontMoveMinY: maxY < self.y, 无法布局");
        return;
    }
    [self setHeight:maxY - self.y];
}

//  setWidth
- (void)setWidth:(CGFloat)width
{
    CGRect tempFrame = self.frame;
    tempFrame.size.width = width;
    self.frame = tempFrame;
}

//  setHeight
- (void)setHeight:(CGFloat)height
{
    CGRect tempFrame = self.frame;
    tempFrame.size.height = height;
    self.frame = tempFrame;
}

//  setOrigin
- (void)setOrigin:(CGPoint)point
{
    CGRect tempFrame = self.frame;
    tempFrame.origin = point;
    self.frame = tempFrame;
}

//  setOrigin sizeToFit
- (void)setOrigin:(CGPoint)point sizeToFit:(BOOL)sizeToFit
{
    if (sizeToFit == YES) {
        [self sizeToFit];
    }
    
    CGRect tempFrame = self.frame;
    tempFrame.origin = point;
    self.frame = tempFrame;
}

//  setSize
- (void)setSize:(CGSize)size
{
    CGRect tempFrame = self.frame;
    tempFrame.size = size;
    self.frame = tempFrame;
}

//  setCenterX
- (void)setCenterX:(CGFloat)x
{
    CGPoint tempCenter = self.center;
    tempCenter.x = x;
    self.center = tempCenter;
}

//  setCenterY
- (void)setCenterY:(CGFloat)y
{
    CGPoint tempCenter = self.center;
    tempCenter.y = y;
    self.center = tempCenter;
}

//  不移动中心－设置width
- (void)setWidth_DonotMoveCenter:(CGFloat)width
{
    CGPoint tempCenter = self.center;
    [self setWidth:width];
    self.center = tempCenter;
}

//  不移动中心－设置height
- (void)setHeight_DonotMoveCenter:(CGFloat)height
{
    CGPoint tempCenter = self.center;
    [self setHeight:height];
    self.center = tempCenter;
}

//  不移动中心－设置height
- (void)setSize_DonotMoveCenter:(CGSize)size
{
    CGPoint tempCenter = self.center;
    [self setSize:size];
    self.center = tempCenter;
}

//  不移动某一侧 siztToFit
- (void)sizeToFit_DonotMoveSide:(kDIRECTION)dir centerRemain:(BOOL)centerRemain
{
    switch (dir) {
        case kDIR_LEFT:
        {
            CGFloat tempX = CGRectGetMinX(self.frame);
            CGFloat tempCenterY = self.center.y;
            [self sizeToFit];
            [self setX:tempX];
            if (centerRemain) {
                [self setCenterY:tempCenterY];
            }
        }
            break;
            
        case kDIR_RIGHT:
        {
            CGFloat tempX = CGRectGetMaxX(self.frame);
            CGFloat tempCenterY = self.center.y;
            [self sizeToFit];
            [self setMaxX:tempX];
            if (centerRemain) {
                [self setCenterY:tempCenterY];
            }
        }
            break;
            
        case kDIR_UP:
        {
            CGFloat tempY = CGRectGetMinY(self.frame);
            CGFloat tempCenterX = self.center.x;
            [self sizeToFit];
            [self setY:tempY];
            if (centerRemain) {
                [self setCenterX:tempCenterX];
            }
        }
            break;
            
        case kDIR_DOWN:
        {
            CGFloat tempY = CGRectGetMaxY(self.frame);
            CGFloat tempCenterX = self.center.x;
            [self sizeToFit];
            [self setMaxY:tempY];
            if (centerRemain) {
                [self setCenterX:tempCenterX];
            }
        }
            break;
            
        default:
            break;
    }
}




#pragma mark 设置布局方法

/**
 *  和父类view剧中
 *
 *  当前view和父类view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToParentViewWithAxis:(kAXIS)axis
{
    UIView *parentView = self.superview;
    switch (axis) {
        case kAXIS_X:
            self.center = CGPointMake(parentView.width/2, self.center.y);
            break;
            
        case kAXIS_Y:
            self.center = CGPointMake(self.center.x, parentView.height/2);
            break;
            
        case kAXIS_X_Y:
            self.center = CGPointMake(parentView.width/2, parentView.height/2);
            break;
            
        default:
            break;
    }
}


/**
 *  和指定的view剧中
 *
 *  当前view和指定view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToView:(UIView *)destinationView withAxis:(kAXIS)axis
{
    if (!destinationView) {
        NSLog(@"!!! setCenterWithAxis: 目标view为nil");
        return;
    }
    
    if (![self.superview isEqual:destinationView.superview]) {
        NSLog(@"!!! setCenterWithAxis: 目标view和当前view不处于同一个父类view之下");
        return;
    }
    
    switch (axis) {
        case kAXIS_X:
            self.center = CGPointMake(self.center.x, destinationView.center.y);
            break;
            
        case kAXIS_Y:
            self.center = CGPointMake(destinationView.center.x, self.center.y);
            break;
            
        case kAXIS_X_Y:
            self.center = CGPointMake(destinationView.center.x, destinationView.center.y);
            break;
            
        default:
            break;
    }
}



/**
 *  相对布局关系参考图
 *
 *
 *  self与destinationView 是是是是是 父子类关系
 *  大方框为destinationView，大方框为self的父类view
 *
 *     ----------     ----------     ----------     ----------
 *    |   self   |   |          |   |          |   |          |
 *    |          |   |          |   |          |   |          |
 *    |          |   |          |   |self      |   |      self|
 *    |          |   |          |   |          |   |          |
 *    |          |   |   self   |   |          |   |          |
 *     ----------     ----------     ----------     ----------
 *
 *
 *  关系： up             down          left           right
 *
 *
 *
 *  self与destinationView 非非非非 父子类关系
 *  大方框为destinationView和self所共有的父类view
 *
 *     ----------     ----------     ----------     ----------
 *    |   self   |   |   dest   |   |          |   |          |
 *    |          |   |          |   |          |   |          |
 *    |          |   |          |   |self  dest|   |dest  self|
 *    |          |   |          |   |          |   |          |
 *    |   dest   |   |   self   |   |          |   |          |
 *     ----------     ----------     ----------     ----------
 *
 *
 *  关系： up             down          left            right
 */

/**
 *  view的相对布局
 *
 *  direction:          方位
 *  destinationView:    目标view
 *  parentRelation:     是否为父子类关系
 *  distance:           距离
 *  center:             是否对应居中
 *
 *  此方法用于设置view与view之间的相对位置
 *  self与destinationView非父子类关系时: 可以设置self相对于destinationView的 上／下／左／右 的边距
 *  self与destinationView是父子类关系时: 可以设置self相对于父类view的 上／下／左／右 的间距
 *  注：parentRelation==YES时，destinationView可以设为nil。
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center
{
    CGRect tempRect = self.frame;
    
    //  self与destinationView 是是是是是 父子类关系
    if (parentRelation) {
        if (!destinationView) {
            destinationView = [self superview];
        }
        
        switch (direction) {
                
                //上边距
            case kDIR_UP:{
                tempRect.origin.y = distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToParentViewWithAxis:kAXIS_X];
                }
            }
                break;
                
                //下边距
            case kDIR_DOWN:{
                tempRect.origin.y = CGRectGetHeight(destinationView.frame) - CGRectGetHeight(self.frame) - distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToParentViewWithAxis:kAXIS_X];
                }
            }
                break;
                
                //左边距
            case kDIR_LEFT:{
                tempRect.origin.x = distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToParentViewWithAxis:kAXIS_Y];
                }
            }
                break;
                
                //右边距
            case kDIR_RIGHT:{
                tempRect.origin.x = CGRectGetWidth(destinationView.frame) - CGRectGetWidth(self.frame) - distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToParentViewWithAxis:kAXIS_Y];
                }
            }
                break;
                
            default:
                break;
        }
    }
    
    //  self与destinationView 非非非非 父子类关系
    else{
        switch (direction) {
            case kDIR_UP:
                tempRect.origin.y = CGRectGetMinY(destinationView.frame) - distance - CGRectGetHeight(self.frame);
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToView:destinationView withAxis:kAXIS_Y];
                }
                break;
                
            case kDIR_DOWN:
                tempRect.origin.y = CGRectGetMaxY(destinationView.frame) + distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToView:destinationView withAxis:kAXIS_Y];
                }
                break;
                
            case kDIR_LEFT:
                tempRect.origin.x = CGRectGetMinX(destinationView.frame) - distance - CGRectGetWidth(self.frame);
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToView:destinationView withAxis:kAXIS_X];
                }
                break;
                
            case kDIR_RIGHT:
                tempRect.origin.x = CGRectGetMaxX(destinationView.frame) + distance;
                self.frame = tempRect;
                if (center) {
                    [self BearSetCenterToView:destinationView withAxis:kAXIS_X];
                }
                break;
                
            default:
                break;
        }
    }
}



/**
 *  view的相对布局，带sizeToFit
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center sizeToFit:(BOOL)sizeToFit
{
    if (sizeToFit == YES) {
        [self sizeToFit];
    }
    
    [self BearSetRelativeLayoutWithDirection:direction destinationView:destinationView parentRelation:parentRelation distance:distance center:center];
}



/**
 *  根据子view自动布局 自动计算:起始点，结束点，间距（三值相等）
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  offStart:       起始点和边框的距离
 *  offEnd:         结束点和边框的距离
 *  gapDistance:    view之间的间距
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center
{
    [self BearAutoLayViewArray:viewArray
                    layoutAxis:layoutAxis
                        center:center
                       offPara:OffParaMake(0, 0, YES)
                       gapPara:GapParaMake(0, YES)
                      gapArray:nil
                     gapDisAll:nil
                superSizeToFit:NO];
}


/**
 *  根据子view自动布局 需要设置:起始点，结束点; 自动计算:间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  offStart:       起始点和边框的距离
 *  offEnd:         结束点和边框的距离
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd
{
    [self BearAutoLayViewArray:viewArray
                    layoutAxis:layoutAxis
                        center:center
                       offPara:OffParaMake(offStart, offEnd, NO)
                       gapPara:GapParaMake(0, YES)
                      gapArray:nil
                     gapDisAll:nil
                superSizeToFit:NO];
}


/**
 *  根据子view自动布局 需要设置:间距; 自动计算:起始点，结束点
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  gapDistance:    view之间的间距
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapDistance:(CGFloat)gapDistance
{
    [self BearAutoLayViewArray:viewArray
                    layoutAxis:layoutAxis
                        center:center
                       offPara:OffParaMake(0, 0, YES)
                       gapPara:GapParaMake(gapDistance, NO)
                      gapArray:nil
                     gapDisAll:nil
                superSizeToFit:NO];
}


/**
 *  根据子view自动布局 需要设置:起始点，结束点，间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  offStart:       起始点和边框的距离
 *  offEnd:         结束点和边框的距离
 *  gapDistance:    view之间的间距
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd gapDistance:(CGFloat)gapDistance
{
    [self BearAutoLayViewArray:viewArray
                    layoutAxis:layoutAxis
                        center:center
                       offPara:OffParaMake(offStart, offEnd, NO)
                       gapPara:GapParaMake(gapDistance, NO)
                      gapArray:nil
                     gapDisAll:nil
                superSizeToFit:YES];
}

/**
 *  根据子view自动布局 需要设置:gapArray间距比例数组，间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  gapArray:       间距比例数组（包括OffStart，OffEnd）
 *  gapDisAll:      间距总和
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapAray:(NSArray *)gapArray gapDisAll:(CGFloat)gapDisAll
{
    [self BearAutoLayViewArray:viewArray
                    layoutAxis:layoutAxis
                        center:center
                       offPara:OffParaMake(0, 0, NO)
                       gapPara:GapParaMake(0, NO)
                      gapArray:[NSMutableArray arrayWithArray:gapArray]
                     gapDisAll:[NSNumber numberWithFloat:gapDisAll]
                superSizeToFit:YES];
}



/**
 *  根据子view自动布局
 *
 *  说明：
 *      自动布局核心代码
 *
 *  viewArray:      装有子类view的数组
 *  layoutAxis:     布局轴向
 *                      kLAYOUT_AXIS_X: 水平方向自动布局
 *                      kLAYOUT_AXIS_Y: 垂直方向自动布局
 *  center:         是否和父类的view居中对其（水平方向布局 则 垂直方向居中；垂直方向布局 则 水平方向居中）
 *  OffPara:        边距参数
 *                      offStart:       起始点和边框的距离
 *                      offEnd:         结束点和边框的距离
 *                      autoCalu:       自动计算offStart和offEnd，边距参数可以都填为0
 *  gapPara:        间距参数
 *                      gapDistance:    view之间的间距
 *                      autoCalu:       自动计算gapDistance，间距参数可以填为0
 *  gapArray:       间距比例数组，包括offStart和offEnd
 *  gapDisAll:      所有间距总和，包括offStart和offEnd
 *  superSizeToFit: 父类view自适应
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray
                  layoutAxis:(kLAYOUT_AXIS)layoutAxis
                      center:(BOOL)center
                     offPara:(OffPara)offPara
                     gapPara:(GapPara)gapPara
                    gapArray:(NSMutableArray *)gapArray
                   gapDisAll:(NSNumber *)gapDisAll
              superSizeToFit:(BOOL)superSizeToFit

{
    
    //  检测viewArray里的元素是否都在同一个view上
    id parentView = [viewArray[0] superview];
    for (UIView *tempSubView in viewArray) {
        if (![parentView isEqual:[tempSubView superview]]) {
            NSLog(@"!!! 父类view不同，无法自动布局");
            return;
        }
    }
    
    
    //  参数设置
    int widthAllSubView         = 0;    //所有子view的宽／高总和
    CGFloat needDistance        = 0;    //需要的宽度／高度
    CGFloat subViewWidthMax_X   = 0;    //子类view宽度／高度最大值
    
    for (UIView *tempSubView in viewArray) {
        if (layoutAxis == kLAYOUT_AXIS_X) {
            widthAllSubView += tempSubView.width;
            subViewWidthMax_X = tempSubView.maxY > subViewWidthMax_X ? tempSubView.maxY : subViewWidthMax_X;
        }
        else if(layoutAxis == kLAYOUT_AXIS_Y) {
            widthAllSubView += tempSubView.height;
            subViewWidthMax_X = tempSubView.maxX > subViewWidthMax_X ? tempSubView.maxX : subViewWidthMax_X;
        }
    }
    
    if (gapArray && gapDisAll) {
        needDistance = widthAllSubView + [gapDisAll floatValue];
    }else{
        needDistance = offPara.offStart + offPara.offEnd + widthAllSubView + ([viewArray count] - 1) * gapPara.gapDistance;
    }
    
    
    //  父类view适应和参数设置
    CGFloat containerWidth;
    CGFloat containerHeight;
    if ([parentView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tempView_Scroll = (UIScrollView *)parentView;
        containerWidth  = tempView_Scroll.contentSize.width;
        containerHeight = tempView_Scroll.contentSize.height;
        
        if (superSizeToFit == YES) {
            CGSize tempSize = tempView_Scroll.contentSize;
            if (layoutAxis == kLAYOUT_AXIS_X) {
                tempSize.width = needDistance;
                tempSize.height = subViewWidthMax_X > tempSize.height ? subViewWidthMax_X : tempSize.height;
            }
            else if(layoutAxis == kLAYOUT_AXIS_Y) {
                tempSize.height = needDistance;
                tempSize.width = subViewWidthMax_X > tempSize.width ? subViewWidthMax_X : tempSize.width;
            }
            tempView_Scroll.contentSize = tempSize;
            containerWidth  = tempView_Scroll.contentSize.width;
            containerHeight = tempView_Scroll.contentSize.height;
        }
    }
    else{
        UIView *tempView = (UIView *)parentView;
        containerWidth  = tempView.width;
        containerHeight = tempView.height;
        
        if (superSizeToFit == YES) {
            if (layoutAxis == kLAYOUT_AXIS_X) {
                [tempView setWidth:needDistance];
                [tempView setHeight:subViewWidthMax_X > tempView.height ? subViewWidthMax_X : tempView.height];
            }
            else if(layoutAxis == kLAYOUT_AXIS_Y) {
                [tempView setHeight:needDistance];
                [tempView setWidth:subViewWidthMax_X > tempView.width ? subViewWidthMax_X : tempView.width];
            }
            containerWidth  = tempView.width;
            containerHeight = tempView.height;
        }
    }
    
    //  自动布局
    if (layoutAxis == kLAYOUT_AXIS_X) {
        
        if (containerWidth < needDistance) {
            NSLog(@"\n=======================\n宽度超出，无法自动布局。\n子类view个数:%lu\n子类view宽总和:%d\noffStart:%f\noffStart:%f\n父类view宽总和:%f\n=======================",(unsigned long)[viewArray count], widthAllSubView, offPara.offStart, offPara.offEnd, containerWidth);
            return;
        }
        
        if (offPara.autoCalu == YES && gapPara.autoCalu == YES) {
            offPara.offStart    = (containerWidth - widthAllSubView)/([viewArray count] + 1);
            offPara.offEnd      = offPara.offStart;
            gapPara.gapDistance = offPara.offStart;
        }
        
        else if (offPara.autoCalu == YES && gapPara.autoCalu == NO) {
            CGFloat gapDistancelAll = gapPara.gapDistance * ([viewArray count] - 1);
            offPara.offStart    = (containerWidth - widthAllSubView - gapDistancelAll) / 2;
            offPara.offEnd      = offPara.offEnd;
        }
        
        else if (offPara.autoCalu == NO && gapPara.autoCalu == YES) {
            gapPara.gapDistance = (containerWidth - widthAllSubView - offPara.offStart - offPara.offEnd)/([viewArray count] - 1);
        }
        
        //  gap数组
        if (!gapArray) {
            gapArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [viewArray count] + 2 - 1; i++) {
                
                //  offStart
                if (i == 0) {
                    [gapArray addObject:[NSNumber numberWithFloat:offPara.offStart]];
                }
                //  offEnd
                else if (i == [viewArray count] + 1 - 1){
                    [gapArray addObject:[NSNumber numberWithFloat:offPara.offEnd]];
                }
                //  gapDis
                else{
                    [gapArray addObject:[NSNumber numberWithFloat:gapPara.gapDistance]];
                }
            }
        }
        
        //  gap比例兑换
        if (gapDisAll) {
            
            //  获取gap份数总和
            CGFloat tempAllGapWidth = 0;
            for (NSNumber *tempPerNum in gapArray) {
                tempAllGapWidth += [tempPerNum floatValue];
            }
            
            //  根据对应比例换算成宽度
            for (int i = 0; i < [gapArray count]; i++) {
                CGFloat gapWidth = (1.0 * [gapArray[i] floatValue] / tempAllGapWidth) * [gapDisAll floatValue];
                gapArray[i] = [NSNumber numberWithFloat:gapWidth];
            }
        }
        
        CGFloat tempX = [gapArray[0] floatValue];//用于存储子view临时的X起点
        for (int i = 0; i < [viewArray count]; i++) {
            
            UIView *tempSubView = viewArray[i];
            [tempSubView setX:tempX];
            tempX += tempSubView.width + [gapArray[i + 1] floatValue];
            
            if (center) {
                tempSubView.center = CGPointMake(tempSubView.center.x, containerHeight/2);
            }
        }
    }
    else if(layoutAxis == kLAYOUT_AXIS_Y) {
        
        if (containerHeight < needDistance) {
            NSLog(@"\n=======================\n宽度超出，无法自动布局。\n子类view个数:%lu\n子类view高总和:%d\noffStart:%f\noffStart:%f\n父类view高总和:%f\n=======================",(unsigned long)[viewArray count], widthAllSubView, offPara.offStart, offPara.offEnd, containerHeight);
            return;
        }
        
        if (offPara.autoCalu == YES && gapPara.autoCalu == YES) {
            offPara.offStart    = (containerHeight - widthAllSubView)/([viewArray count] + 1);
            offPara.offEnd      = offPara.offStart;
            gapPara.gapDistance = offPara.offStart;
        }
        
        else if (offPara.autoCalu == YES && gapPara.autoCalu == NO) {
            CGFloat gapDistancelAll = gapPara.gapDistance * ([viewArray count] - 1);
            offPara.offStart    = (containerHeight - widthAllSubView - gapDistancelAll) / 2;
            offPara.offEnd      = offPara.offEnd;
        }
        
        else if (offPara.autoCalu == NO && gapPara.autoCalu == YES) {
            gapPara.gapDistance = (containerHeight - widthAllSubView - offPara.offStart - offPara.offEnd)/([viewArray count] - 1);
        }
        
        //  gap数组
        if (!gapArray) {
            gapArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < [viewArray count] + 2 - 1; i++) {
                
                //  offStart
                if (i == 0) {
                    [gapArray addObject:[NSNumber numberWithFloat:offPara.offStart]];
                }
                //  offEnd
                else if (i == [viewArray count] + 1 - 1){
                    [gapArray addObject:[NSNumber numberWithFloat:offPara.offEnd]];
                }
                //  gapDis
                else{
                    [gapArray addObject:[NSNumber numberWithFloat:gapPara.gapDistance]];
                }
            }
        }
        
        //  gap比例兑换
        if (gapDisAll) {
            
            //  获取gap份数总和
            CGFloat tempAllGapWidth = 0;
            for (NSNumber *tempPerNum in gapArray) {
                tempAllGapWidth += [tempPerNum floatValue];
            }
            
            //  根据对应比例换算成宽度
            for (int i = 0; i < [gapArray count]; i++) {
                CGFloat gapWidth = (1.0 * [gapArray[i] floatValue] / tempAllGapWidth) * [gapDisAll floatValue];
                gapArray[i] = [NSNumber numberWithFloat:gapWidth];
            }
        }
        
        CGFloat tempX = [gapArray[0] floatValue];//用于存储子view临时的X起点
        for (int i = 0; i < [viewArray count]; i++) {
            
            UIView *tempSubView = viewArray[i];
            [tempSubView setY:tempX];
            tempX += tempSubView.height + [gapArray[i + 1] floatValue];
            
            if (center) {
                //竖直方向相对于父类view剧中
                tempSubView.center = CGPointMake(containerWidth/2, tempSubView.center.y);
            }
        }
    }
}

@end
