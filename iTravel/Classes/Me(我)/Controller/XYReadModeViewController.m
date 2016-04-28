//
//  XYReadMoreViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYReadModeViewController.h"
#import "XYSettingCheckItem.h"
#import "XYSettingSwitchItem.h"
#import "XYSettingLabelItem.h"
#import "XYSettingCheckGroup.h"

@interface XYReadModeViewController ()

@end

@implementation XYReadModeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 添加组
    XYSettingCheckGroup *group = [XYSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    XYSettingCheckItem *with = [XYSettingCheckItem itemWithTitle:@"有图模式"];
    XYSettingCheckItem *without = [XYSettingCheckItem itemWithTitle:@"无图模式"];
    group.items = @[with, without];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}

- (void)setupGroup1
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingSwitchItem *show = [XYSettingSwitchItem itemWithTitle:@"显示缩略微博"];
    
    group.items = @[show];
}


@end
