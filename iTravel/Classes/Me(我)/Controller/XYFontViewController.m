//
//  XYFontViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYFontViewController.h"
#import "XYSettingCheckItem.h"
#import "XYSettingCheckGroup.h"
#import "XYSettingLabelItem.h"

@interface XYFontViewController ()
@end

@implementation XYFontViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加组
    XYSettingCheckGroup *group = [XYSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    XYSettingCheckItem *big = [XYSettingCheckItem itemWithTitle:@"大"];
    XYSettingCheckItem *middle = [XYSettingCheckItem itemWithTitle:@"中"];
    XYSettingCheckItem *small = [XYSettingCheckItem itemWithTitle:@"小"];
    group.items = @[big, middle, small];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}


@end
