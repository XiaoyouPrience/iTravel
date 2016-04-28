//
//  XYSettingItem.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingItem.h"

@implementation XYSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    XYSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}
@end
