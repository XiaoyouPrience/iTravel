//
//  XYSettingCell.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYBgCell.h"
@class XYSettingItem;

@interface XYSettingCell : XYBgCell

@property (strong, nonatomic) XYSettingItem *item;
@property (strong, nonatomic) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
