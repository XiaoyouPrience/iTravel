//
//  XYBgCell.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//  cell-- 基类。。有背景的cell

#import <UIKit/UIKit.h>

@interface XYBgCell : UITableViewCell

@property (weak, nonatomic) UIImageView *bg;
@property (weak, nonatomic) UIImageView *selectedBg;

@end
