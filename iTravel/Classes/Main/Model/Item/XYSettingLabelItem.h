//
//  XYSettingLabelItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingValueItem.h"

@interface XYSettingLabelItem : XYSettingValueItem
/**文字*/
@property (copy, nonatomic) NSString *text;
/**默认文字*/
@property (copy, nonatomic) NSString *defaultText;

@end
