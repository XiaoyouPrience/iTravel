//
//  XYMapViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYMapViewController.h"
#import "XYBadgeButton.h"
#import "XYSearchBar.h"

@implementation XYMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.导航栏上面的搜索框
    XYSearchBar *searchBar = [XYSearchBar searchBar];
    
//    searchBar.frame = CGRectMake(0, 0, 300, 30);
    
    self.navigationItem.titleView = searchBar;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    XYBadgeButton *button = [[XYBadgeButton alloc] init];
    button.center = CGPointMake(200, 200);
    button.badgeValue = @"100";
    [self.view addSubview:button];
    
}



@end
