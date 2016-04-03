//
//  XYStatusCell.h
//  iTravel
//
//  Created by XiaoYou on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XYStatusFrame;
@interface XYStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) XYStatusFrame *statusFrame;

@end
