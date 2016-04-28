//
//  XYSettingValueItem.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingValueItem.h"

@implementation XYSettingValueItem

- (NSString *)key
{
    return _key ? _key : self.title;
}

@end
