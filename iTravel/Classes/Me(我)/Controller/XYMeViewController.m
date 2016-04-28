//
//  XYMeViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYMeViewController.h"
#import "XYSettingArrowItem.h"
#import "XYSettingGroup.h"
#import "XYSystemSettingViewController.h"


@interface XYMeViewController ()

@end

@implementation XYMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    //    [self setupGroup3];
}

/**
 *  设置
 */
- (void)setting
{
    XYSystemSettingViewController *sys = [[XYSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)setupGroup0
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *newFriend = [XYSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"4";
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *album = [XYSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    XYSettingArrowItem *collect = [XYSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    XYSettingArrowItem *like = [XYSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *pay = [XYSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    XYSettingArrowItem *vip = [XYSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *card = [XYSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    XYSettingArrowItem *draft = [XYSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
