//
//  XYSettingCheckGroup.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingGroup.h"

@class XYSettingCheckItem,XYSettingLabelItem;

@interface XYSettingCheckGroup : XYSettingGroup
/**
 *  选中的索引
 */
@property (assign, nonatomic) int checkedIndex;

/**
 *  选中的item
 */
@property (strong, nonatomic) XYSettingCheckItem *checkedItem;

/**
 *  来源于哪个item
 */
@property (strong, nonatomic) XYSettingLabelItem *sourceItem;

@end
