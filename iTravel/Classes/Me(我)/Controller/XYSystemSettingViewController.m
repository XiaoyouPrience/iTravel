//
//  XYSystemSettingViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSystemSettingViewController.h"
#import "XYSettingArrowItem.h"
#import "XYSettingGroup.h"
#import "XYThemeBgViewController.h"
#import "XYGeneralViewController.h"

@interface XYSystemSettingViewController ()

@end

@implementation XYSystemSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = XYStatusTableBorder + 2;
    CGFloat logoutY = 0;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resiedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resiedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + XYStatusCellBorder;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)setupGroup0
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *account = [XYSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *theme = [XYSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:[XYThemeBgViewController class]];
    group.items = @[theme];
}

- (void)setupGroup2
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *notice = [XYSettingArrowItem itemWithTitle:@"通知和提醒"];
    XYSettingArrowItem *general = [XYSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[XYGeneralViewController class]];
    XYSettingArrowItem *safe = [XYSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];
}

- (void)setupGroup3
{
    XYSettingGroup *group = [self addGroup];
    
    XYSettingArrowItem *opinion = [XYSettingArrowItem itemWithTitle:@"意见反馈"];
    XYSettingArrowItem *about = [XYSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}

@end
