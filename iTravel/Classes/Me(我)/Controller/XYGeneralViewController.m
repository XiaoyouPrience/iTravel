//
//  XYGeneralViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYGeneralViewController.h"
#import "XYSettingArrowItem.h"
#import "XYSettingSwitchItem.h"
#import "XYSettingLabelItem.h"
#import "XYSettingGroup.h"
#import "XYReadModeViewController.h"
#import "XYFontViewController.h"
#import "XYLanguageViewController.h"
#import "XYIconQualityViewController.h"

@interface XYGeneralViewController ()

@end

@implementation XYGeneralViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup0
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingLabelItem *read = [XYSettingLabelItem itemWithTitle:@"阅读模式" destVcClass:[XYReadModeViewController class]];
    read.defaultText = @"有图模式";
    read.readyForDestVc = ^(XYSettingLabelItem *item, XYReadModeViewController *destVc){
        destVc.sourceItem = item;
    };
    
    XYSettingLabelItem *font = [XYSettingLabelItem itemWithTitle:@"字号大小" destVcClass:[XYFontViewController class]];
    font.defaultText = @"中";
    font.readyForDestVc = ^(XYSettingLabelItem *item, XYFontViewController *destVc){
        destVc.sourceItem = item;
    };
    
    XYSettingSwitchItem *mark = [XYSettingSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[read, font, mark];
}

- (void)setupGroup1
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *picture = [XYSettingArrowItem itemWithTitle:@"图片质量设置" destVcClass:[XYIconQualityViewController class]];
    group.items = @[picture];
}

- (void)setupGroup2
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingSwitchItem *voice = [XYSettingSwitchItem itemWithTitle:@"声音"];
    group.items = @[voice];
}

- (void)setupGroup3
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingLabelItem *language = [XYSettingLabelItem itemWithTitle:@"多语言环境" destVcClass:[XYLanguageViewController class]];
    language.defaultText = @"跟随系统";
    language.readyForDestVc = ^(XYSettingLabelItem *item, XYLanguageViewController *destVc){
        destVc.sourceItem = item;
    };
    group.items = @[language];
}

- (void)setupGroup4
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *clearCache = [XYSettingArrowItem itemWithTitle:@"清除图片缓存"];
    XYSettingArrowItem *clearHistory = [XYSettingArrowItem itemWithTitle:@"清空搜索历史"];
    group.items = @[clearCache, clearHistory];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

@end
