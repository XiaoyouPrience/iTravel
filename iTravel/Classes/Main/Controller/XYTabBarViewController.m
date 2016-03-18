//
//  XYTabBarViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTabBarViewController.h"
#import "XYMapViewController.h"
#import "XYWeiBoViewController.h"
#import "XYDiscoverViewController.h"
#import "XYMeViewController.h"
#import "UIImage+XY.h"
#import "XYTabbar.h"
#import "XYNavigationController.h"

@interface XYTabBarViewController ()<XYTabbarDelegate>

@property (nonatomic,weak) XYTabbar *costomTabbar;
@end

@implementation XYTabBarViewController

/**
 *  居然没有这个方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化自定制 Tabbar
    [self setupTabbar];
    
    // 初始化子控制器
    [self setupChildViewControllers];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 只有在将要显示的时才会有Tabbar上面的button --> 删除上面自带的button
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
}


/**
 *  初始化Tabbar
 */
-(void)setupTabbar
{
    // 创建并添加到系统Tabbar上面
    XYTabbar *costomTabBar = [[XYTabbar alloc] init];
    costomTabBar.frame = self.tabBar.bounds; // 设置位置必须用bounds，因为这样才能显示到tabbar 上
    [self.tabBar addSubview:costomTabBar];
    costomTabBar.delegate = self;
    
    // 赋值给成员变量
    self.costomTabbar = costomTabBar;
}
/**
 *  tabBar代理方法
 */
- (void)tabBar:(XYTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    NSLog(@"%d ---- > %d",from,to);
    
    // 抓取到要去的控制器，跳转
    self.selectedIndex = to;
}



/**
 *  初始化子控制器
 */
-(void)setupChildViewControllers
{
    // 初始化子控制器
    XYMapViewController *mapVC = [[XYMapViewController alloc] init];
    
    // TabbarItem模型的数据必须先赋值，在后面调用的时候才会有值
    mapVC.tabBarItem.badgeValue = @"weee";
    mapVC.view.backgroundColor = [UIColor blackColor];
    [self setupChildViewControllers:mapVC title:@"地图" imageName:@"tabbar_home" seletedImageName:@"tabbar_home_selected"];
    
    
    
    XYWeiBoViewController *navVc = [[XYWeiBoViewController alloc] init];
    navVc.tabBarItem.badgeValue = @"weee";
    [self setupChildViewControllers:navVc title:@"微博" imageName:@"tabbar_message_center" seletedImageName:@"tabbar_message_center_selected"];
    
    
    XYDiscoverViewController *disVC = [[XYDiscoverViewController alloc] init];
    disVC.tabBarItem.badgeValue = @"1";
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
    XYNavigationController *childNav = [[XYNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:childNav];
    
    // 4.加载Tabbar按钮
    [self.costomTabbar addTabBarButtonWithItem:childVC.tabBarItem];
    
}




@end
