//
//  XYSettingCheckItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  打对勾模型

#import "XYSettingItem.h"

@interface XYSettingCheckItem : XYSettingItem
/**判断是否是已经打对勾*/
@property (assign, nonatomic, getter = isChecked) BOOL checked;

@end
