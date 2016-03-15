//
//  XYMapViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYMapViewController.h"
#import "XYBadgeButton.h"

@implementation XYMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    add.frame = CGRectMake(100, 100, 100, 100);
    [add addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];

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

- (void)addClick
{
    self.tabBarItem.badgeValue = @"2900";
    
    DLog(@"%@",self.tabBarItem.badgeValue);
}

@end
