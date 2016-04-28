//
//  XYSettingLabelItem.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingLabelItem.h"

@implementation XYSettingLabelItem

- (NSString *)text
{
    id value = [kUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.defaultText;
    } else {
        return value;
    }
}

- (void)setText:(NSString *)text
{
    [kUserDefaults setObject:text forKey:self.key];
    [kUserDefaults synchronize];
}

@end
