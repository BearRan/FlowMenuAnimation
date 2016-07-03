//
//  CellDataModel.h
//  FlowMenuAnimation
//
//  Created by Bear on 16/7/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellDataModel : NSObject

@property (strong, nonatomic) NSString  *nameStr;
@property (strong, nonatomic) NSString  *imageNameStr;
@property (strong, nonatomic) NSString  *followersNum;
@property (strong, nonatomic) NSString  *favoritesNum;
@property (strong, nonatomic) NSString  *viewsNum;

@property (strong, nonatomic) UIColor   *myColor_dark;
@property (strong, nonatomic) UIColor   *myColor_normal;
@property (strong, nonatomic) UIColor   *myColor_light;

@end
