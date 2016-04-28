//
//  XYSettingSwitchItem.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingSwitchItem.h"

@implementation XYSettingSwitchItem

- (id)init
{
    if (self = [super init]) {
        self.defaultOn = YES;
    }
    return self;
}

- (BOOL)isOn
{
    id value = [kUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.isDefaultOn;
    } else {
        return [value boolValue];
    }
}

- (void)setOn:(BOOL)on
{
    [kUserDefaults setBool:on forKey:self.key];
    [kUserDefaults synchronize];
}

@end
