//
//  XYSettingViewController.h
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYSettingGroup;

@interface XYSettingViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *groups;

- (XYSettingGroup *)addGroup;
@end
