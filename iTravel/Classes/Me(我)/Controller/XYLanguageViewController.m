//
//  XYLanguageViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYLanguageViewController.h"
#import "XYSettingCheckItem.h"
#import "XYSettingCheckGroup.h"
#import "XYSettingLabelItem.h"

@interface XYLanguageViewController ()

@end

@implementation XYLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加组
    XYSettingCheckGroup *group = [XYSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    XYSettingCheckItem *sys = [XYSettingCheckItem itemWithTitle:@"跟随系统"];
    XYSettingCheckItem *simple = [XYSettingCheckItem itemWithTitle:@"简体中文"];
    XYSettingCheckItem *complex = [XYSettingCheckItem itemWithTitle:@"繁體中文"];
    XYSettingCheckItem *english = [XYSettingCheckItem itemWithTitle:@"English"];
    group.items = @[sys, simple, complex, english];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}


@end
