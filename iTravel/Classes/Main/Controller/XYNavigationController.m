//
//  XYNavigationController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/16.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYNavigationController.h"

@implementation XYNavigationController

// 一个类只有在第一次调用的时候会调用一次。
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
    
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    if (!iOS7) { // ios7是扁平化没有背景图片
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    // 设置文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    //    disableTextAttrs[UITextAttributeTextColor] =  [UIColor lightGrayColor];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = iOS7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:iOS7 ? 15 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
////    disableTextAttrs[UITextAttributeTextColor] =  [UIColor lightGrayColor];
//    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor lightGrayColor];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    // 取出apperence对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if (!iOS7) {
        // 当ios7以上的时候，导航栏直接是64，两个是在一起的
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        // 避免状态栏被同化，重新设置状态栏颜色
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    // 2.设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:19];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowColor] = [UIColor redColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero ];
    navBar.titleTextAttributes = textAttrs;
}



// 拦截子控制器的push方法，
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 当push栈中有控制器的时候就再隐藏bottomBar
    if (self.viewControllers.count > 1) {
        // 被push的ViewController隐藏BottomBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 重写父类的方法
    [super pushViewController:viewController animated:animated];
}

@end
