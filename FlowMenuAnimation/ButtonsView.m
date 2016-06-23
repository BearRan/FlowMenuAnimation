//
//  ButtonsView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ButtonsView.h"
#import "SpecialBtn.h"

@interface ButtonsView ()
{
    NSArray *_btnArray;
    
}

@end

@implementation ButtonsView



- (instancetype)initWithFrame:(CGRect)frame btnsArray:(NSArray *)btnArray
{
    self = [super initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height)];
    
    if (self) {
        self.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
        _btnArray = btnArray;
        _aniamtionDuring = 1.0;
    }
    
    return self;
}


- (void)showBtnsAnimation
{
    for (int i = 0; i < [_btnArray count]; i++) {
        SpecialBtn *specialBtn = _btnArray[i];
        specialBtn.keyFrameAniamtion.keyPath = @"position";
        specialBtn.keyFrameAniamtion.path = _beizerPath.CGPath;
        [specialBtn.keyFrameAniamtion setDuration:_aniamtionDuring];
//        specialBtn.keyFrameAniamtion.s
    }
}

- (void)closeBtnsAniamtion
{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
