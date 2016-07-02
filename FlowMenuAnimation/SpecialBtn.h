//
//  SpecialBtn.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialBtn : UIButton

@property (nonatomic) UIDynamicItemCollisionBoundsType collisionBoundsType NS_AVAILABLE_IOS(9_0);
@property (strong, nonatomic) CAKeyframeAnimation   *keyFrameAniamtion;

@end
