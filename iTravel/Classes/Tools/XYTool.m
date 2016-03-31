//
//  XYTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/1.
//  Copyright © 2016年 XY. All rights reserved.
//  整个项目的工具类

#import "XYTool.h"
#import "XYTabBarViewController.h"
#import "XYNewFeatureViewController.h"


@implementation XYTool

/**
 *  选择跳转那个根控制器
 */
+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XYTabBarViewController alloc] init];
    } else { // 新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[XYNewFeatureViewController alloc] init];
        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
