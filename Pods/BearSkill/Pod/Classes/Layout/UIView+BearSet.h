//
//  UIView+BearSet.h
//
//  Created by bear on 15/11/25.
//  Copyright (c) 2015年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kAXIS_Y,
    kAXIS_X,
    kAXIS_X_Y,
}kAXIS;

typedef enum {
    kLAYOUT_AXIS_Y,
    kLAYOUT_AXIS_X,
}kLAYOUT_AXIS;

typedef enum {
    kDIR_LEFT,
    kDIR_RIGHT,
    kDIR_UP,
    kDIR_DOWN,
}kDIRECTION;


//  offParameter结构体
struct OffPara
{
    CGFloat offStart;
    CGFloat offEnd;
    BOOL    autoCalu;
};
typedef struct OffPara OffPara;

//  offParameter内联
CG_INLINE OffPara
OffParaMake(CGFloat offStart, CGFloat offEnd, BOOL autoCalu)
{
    OffPara offPara;
    offPara.offStart    = offStart;
    offPara.offEnd      = offEnd;
    offPara.autoCalu    = autoCalu;
    return offPara;
}


//  gapParameter结构体
struct GapPara
{
    CGFloat gapDistance;
    BOOL    autoCalu;
};
typedef struct GapPara GapPara;

//  gapParameter内联
CG_INLINE GapPara
GapParaMake(CGFloat gapDistance, BOOL autoCalu)
{
    GapPara gapPara;
    gapPara.gapDistance = gapDistance;
    gapPara.autoCalu    = autoCalu;
    return gapPara;
}


@interface UIView (BearSet)

/**
 *  普通的方法
 */

// 毛玻璃效果处理
- (void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha;

// 设置边框
- (void)setMyBorder:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 自定义分割线View OffY
- (void)setMySeparatorLineOffY:(int)offStart offEnd:(int)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor offY:(CGFloat)offY;

// 自定义底部分割线View
- (void)setMySeparatorLine:(CGFloat)offStart offEnd:(CGFloat)offEnd lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;

// 通过view，画任意方向的线
- (void)drawLine:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;


// 通过layer，画任意方向的线
- (void)drawLineWithLayer:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;





/**
 *  布局扩展方法
 */


//  Getter

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (CGFloat)width;
- (CGFloat)height;
- (CGPoint)origin;
- (CGSize)size;

- (CGFloat)centerX;
- (CGFloat)centerY;


//Setter

- (void)setX:(CGFloat)x;
- (void)setMaxX:(CGFloat)maxX;
- (void)setMaxX_DontMoveMinX:(CGFloat)maxX;

- (void)setY:(CGFloat)y;
- (void)setMaxY:(CGFloat)maxY;
- (void)setMaxY_DontMoveMinY:(CGFloat)maxY;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setOrigin:(CGPoint)point;
- (void)setOrigin:(CGPoint)point sizeToFit:(BOOL)sizeToFit;
- (void)setSize:(CGSize)size;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

- (void)setWidth_DonotMoveCenter:(CGFloat)width;
- (void)setHeight_DonotMoveCenter:(CGFloat)height;
- (void)setSize_DonotMoveCenter:(CGSize)size;
- (void)sizeToFit_DonotMoveSide:(kDIRECTION)dir centerRemain:(BOOL)centerRemain;


/**
 *  和父类view剧中
 *
 *  当前view和父类view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToParentViewWithAxis:(kAXIS)axis;


/**
 *  和指定的view剧中
 *
 *  当前view和指定view的 X轴／Y轴／中心点 对其
 */
- (void)BearSetCenterToView:(UIView *)destinationView withAxis:(kAXIS)axis;


/**
 *  view与view的相对位置
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center;


/**
 *  view的相对布局，带sizeToFit
 */
- (void)BearSetRelativeLayoutWithDirection:(kDIRECTION)direction destinationView:(UIView *)destinationView parentRelation:(BOOL)parentRelation distance:(CGFloat)distance center:(BOOL)center sizeToFit:(BOOL)sizeToFit;


/**
 *  根据子view自动布局 自动计算:起始点，结束点，间距（三值相等）
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center;


/**
 *  根据子view自动布局 需要设置:起始点，结束点; 自动计算:间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd;


/**
 *  根据子view自动布局 需要设置:间距; 自动计算:起始点，结束点
 *  说明： 在父类view尺寸不等于需求尺寸时，会显示日志并且取消布局
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 需要设置:起始点，结束点，间距
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center offStart:(CGFloat)offStart offEnd:(CGFloat)offEnd gapDistance:(CGFloat)gapDistance;


/**
 *  根据子view自动布局 需要设置:gapArray间距比例数组，间距总和
 *  说明： 在父类view尺寸不等于需求尺寸时，会自动变化
 */
+ (void)BearAutoLayViewArray:(NSMutableArray *)viewArray layoutAxis:(kLAYOUT_AXIS)layoutAxis center:(BOOL)center gapAray:(NSArray *)gapArray gapDisAll:(CGFloat)gapDisAll;

@end
