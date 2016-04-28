//
//  XYIconQualityViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYIconQualityViewController.h"
#import "XYSettingLabelItem.h"
#import "XYSettingCheckItem.h"
#import "XYSettingCheckGroup.h"

@interface XYIconQualityViewController ()

@end

@implementation XYIconQualityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroupWithHeader:(NSString *)header
{
    // 添加组
    XYSettingCheckGroup *group = [XYSettingCheckGroup group];
    group.header = header;
    [self.groups addObject:group];
    
    // 设置数据
    XYSettingCheckItem *high = [XYSettingCheckItem itemWithTitle:@"高清"];
    high.subtitle = @"(建议在wifi或3G网络使用)";
    XYSettingCheckItem *normal = [XYSettingCheckItem itemWithTitle:@"普通"];
    normal.subtitle = @"(上传速度快，省流量)";
    group.items = @[high, normal];
    
    XYSettingLabelItem *item = [XYSettingLabelItem item];
    item.key = group.header;
    item.defaultText = high.title;
    group.sourceItem = item;
}

- (void)setupGroup0
{
    [self setupGroupWithHeader:@"上传图片质量"];
}

- (void)setupGroup1
{
    [self setupGroupWithHeader:@"下载图片质量"];
}


@end
