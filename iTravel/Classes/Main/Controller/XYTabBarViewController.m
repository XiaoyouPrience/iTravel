//
//  XYTabBarViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTabBarViewController.h"
#import "XYMapViewController.h"
#import "XYNavigationViewController.h"
#import "XYDiscoverViewController.h"
#import "XYMeViewController.h"
#import "UIImage+XY.h"

@interface XYTabBarViewController ()


@end

@implementation XYTabBarViewController

/**
 *  居然没有这个方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 初始化子控制器
    [self setupChildViewControllers];
    

}
/**
 *  初始化子控制器
 */
-(void)setupChildViewControllers
{
    // 初始化子控制器
    XYMapViewController *mapVC = [[XYMapViewController alloc] init];
    [self setupChildViewControllers:mapVC title:@"地图" imageName:@"tabbar_home" seletedImageName:@"tabbar_home_selected"];
    
    
    XYNavigationViewController *navVc = [[XYNavigationViewController alloc] init];
    [self setupChildViewControllers:navVc title:@"导航" imageName:@"tabbar_message_center" seletedImageName:@"tabbar_message_center_selected"];
    
    
    XYDiscoverViewController *disVC = [[XYDiscoverViewController alloc] init];
    [self setupChildViewControllers:disVC title:@"发现" imageName:@"tabbar_discover" seletedImageName:@"tabbar_discover_selected"];
    
    
    XYMeViewController *meVC = [[XYMeViewController alloc] init];
    [self setupChildViewControllers:meVC title:@"我" imageName:@"tabbar_profile" seletedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化子控制器
 *
 *  @param childVC          childVc
 *  @param title            title
 *  @param imageName        imageName
 *  @param seletedImageName seletedImageName
 */
- (void)setupChildViewControllers:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName seletedImageName:(NSString *)seletedImageName
{
    // 0.设置标题
    childVC.title = title;
    
    // 1.设置图标
    childVC.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 2.设置选中图标
    if (iOS7) {
        // 如果是ios7 就设置图片不要被渲染
        childVC.tabBarItem.selectedImage = [[UIImage imageWithName:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else
    {   // ios7 以下就直接使用图标
        childVC.tabBarItem.selectedImage = [UIImage imageWithName:seletedImageName];
    }
    
    // 3.设置导航栏
    UINavigationController *childNav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:childNav];
}




@end
