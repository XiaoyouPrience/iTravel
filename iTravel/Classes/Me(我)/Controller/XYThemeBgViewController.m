//
//  XYThemeBgViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYThemeBgViewController.h"

#import "XYSettingArrowItem.h"
#import "XYSettingGroup.h"

@interface XYThemeBgViewController ()

@end

@implementation XYThemeBgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *theme = [XYSettingArrowItem itemWithTitle:@"主题"];
    group.items = @[theme];
}

- (void)setupGroup1
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *bg = [XYSettingArrowItem itemWithTitle:@"背景"];
    group.items = @[bg];
}

@end
