//
//  XYSettingItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  设置页面 cell 的 Item 基类

#import <Foundation/Foundation.h>

typedef void(^XYSettingItemOption)();

@interface XYSettingItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) XYSettingItemOption option;
@property (copy, nonatomic) NSString *badgeValue;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;

@end
