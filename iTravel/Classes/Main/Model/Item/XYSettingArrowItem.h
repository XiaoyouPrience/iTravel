//
//  XYSettingArrowItem.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  有箭头的item -- 表示有下一级

#import "XYSettingItem.h"

@class XYSettingArrowItem;

typedef void(^XYSettingArrowItemReadyForDestVc)(id item, id destVC);


@interface XYSettingArrowItem : XYSettingItem


@property (assign, nonatomic) Class destVcClass;
@property (copy, nonatomic) XYSettingArrowItemReadyForDestVc readyForDestVc;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
