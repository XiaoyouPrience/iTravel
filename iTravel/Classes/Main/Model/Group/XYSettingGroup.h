//
//  XYSettingGroup.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  设置页面 -- 组模型基类

#import <Foundation/Foundation.h>

@interface XYSettingGroup : NSObject

@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSString *footer;
@property (strong, nonatomic) NSArray *items;

+ (instancetype)group;

@end
