//
//  XYSettingSwitchItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  记录Switch开关状态的Item

#import "XYSettingValueItem.h"

@interface XYSettingSwitchItem : XYSettingValueItem

@property (assign, nonatomic, getter = isOn) BOOL on;
@property (assign, nonatomic, getter = isDefaultOn) BOOL defaultOn;

@end
