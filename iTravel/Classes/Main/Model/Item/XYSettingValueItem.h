//
//  XYSettingValueItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  表示--箭头Item的子类，它对应的key

#import "XYSettingArrowItem.h"

@interface XYSettingValueItem : XYSettingArrowItem

/**键*/
@property (copy, nonatomic) NSString *key;

@end
