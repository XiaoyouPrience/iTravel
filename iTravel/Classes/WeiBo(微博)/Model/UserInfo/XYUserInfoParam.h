//
//  XYUserInfoParam.h
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//
//  封装加载用户信息的参数

#import "XYBaseParam.h"     // --- 这个居然给自动引入了，挺好

@interface XYUserInfoParam : XYBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;

@end
