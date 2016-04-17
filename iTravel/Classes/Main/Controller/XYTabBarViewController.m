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
#import "XYUserTool.h"
#import "XYAccount.h"
#import "XYAccountTool.h"

#import "HyPopMenuView.h" // 加号按钮弹出pop效果
#import "XYComposeViewController.h"

#define Objs @[[MenuLabel CreatelabelIconName:@"tabbar_compose_idea" Title:@"文字"],[MenuLabel CreatelabelIconName:@"tabbar_compose_photo" Title:@"相册"],[MenuLabel CreatelabelIconName:@"tabbar_compose_camera" Title:@"拍摄"],[MenuLabel CreatelabelIconName:@"tabbar_compose_lbs" Title:@"签到"],[MenuLabel CreatelabelIconName:@"tabbar_compose_review" Title:@"点评"],[MenuLabel CreatelabelIconName:@"tabbar_compose_more" Title:@"更多"],]

@interface XYTabBarViewController ()<XYTabbarDelegate>

@property (nonatomic,weak) XYTabbar *costomTabbar;
@property (nonatomic, strong)XYMapViewController *mapVC;
@property (nonatomic, strong)XYWeiBoViewController *navVc;
@property (nonatomic, strong)XYDiscoverViewController *disVC;
@property (nonatomic, strong)XYMeViewController *meVC;
@property (nonatomic, strong)NSTimer *timer;

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
    
    // 3.定时检查更新
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(checkUnreadMessage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
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
 *  定时检查更新
 */
- (void)checkUnreadMessage
{
    DLog(@"--------checkUnreadMessage--------");
    
    // 1.请求参数
    XYUserUnreadCountParam *param = [XYUserUnreadCountParam param];
    param.uid = @([XYAccountTool account].uid);
    
    // 2.发送请求
    [XYUserTool userUnreadMessageCountWithParam:param success:^(XYUserUnreadCountResult *result) {
        // 3.设置badgeValue
//        // 3.1.地图
//        self.mapVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 3.2.微博
        self.navVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        DLog(@"%d",result.status);
        
        // 3.3.我
        self.meVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
    } failure:^(NSError *error) {
        
    }];

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
 *  初始化子控制器
 */
-(void)setupChildViewControllers
{
    // 初始化子控制器
    XYMapViewController *mapVC = [[XYMapViewController alloc] init];
    
    // TabbarItem模型的数据必须先赋值，在后面调用的时候才会有值
//    mapVC.tabBarItem.badgeValue = @"weee";
    mapVC.view.backgroundColor = [UIColor blackColor];
    [self setupChildViewControllers:mapVC title:@"地图" imageName:@"tabbar_home" seletedImageName:@"tabbar_home_selected"];
    self.mapVC = mapVC;
    
    
    
    XYWeiBoViewController *navVc = [[XYWeiBoViewController alloc] init];
//    navVc.tabBarItem.badgeValue = @"weee";
    [self setupChildViewControllers:navVc title:@"微博" imageName:@"tabbar_message_center" seletedImageName:@"tabbar_message_center_selected"];
    self.navVc = navVc;

    
    XYDiscoverViewController *disVC = [[XYDiscoverViewController alloc] init];
//    disVC.tabBarItem.badgeValue = @"1";
    [self setupChildViewControllers:disVC title:@"发现" imageName:@"tabbar_discover" seletedImageName:@"tabbar_discover_selected"];
    self.disVC = disVC;
    
    XYMeViewController *meVC = [[XYMeViewController alloc] init];
    [self setupChildViewControllers:meVC title:@"我" imageName:@"tabbar_profile" seletedImageName:@"tabbar_profile_selected"];
    self.meVC = meVC;
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


#pragma mark - XYTabBar代理方法
/**
 *  监听Tabbar按钮点击跳转
 */
- (void)tabBar:(XYTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    NSLog(@"%d ---- > %d",from,to);
    
    // 抓取到要去的控制器，跳转
    self.selectedIndex = to;
    
    // 当用户点击 微博 的时候调用刷新
    if (to == 1) {
        [self.navVc refresh];
    }
}

/**
 *  监听Tabbar加号按钮点击pop出一个新View
 */
- (void)tabBarDidClickPlusBtn:(XYTabbar *)tabbar
{
    // 1.popMenu 多功能
//    [self popMenu];
    
    
    // 2.直接进入发微博
    XYComposeViewController *compose = [[XYComposeViewController alloc] init];
    XYNavigationController *nav = [[XYNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)popMenu
{
    CGFloat x,y,w,h;
    x = CGRectGetWidth(self.view.bounds)/2 - 213/2;
    y = CGRectGetHeight([UIScreen mainScreen].bounds)/2 * 0.3f;
    w = 213;
    h = 57;
    //自定义的头部视图
    UIImageView *topView = [[ImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topView.image = [UIImage imageNamed:@"compose_slogan"];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSMutableDictionary *AudioDictionary = [NSMutableDictionary dictionary];
    
    //添加弹出菜单音效
    [AudioDictionary setObject:@"composer_open" forKey:kHyPopMenuViewOpenAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewOpenAudioTypeKey];
    //添加取消菜单音效
    [AudioDictionary setObject:@"composer_close" forKey:kHyPopMenuViewCloseAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewCloseAudioTypeKey];
    //添加选中按钮音效
    [AudioDictionary setObject:@"composer_select" forKey:kHyPopMenuViewSelectAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewSelectAudioTypeKey];
    
    [HyPopMenuView CreatingPopMenuObjectItmes:Objs TopView:topView /*nil*/OpenOrCloseAudioDictionary:AudioDictionary /*nil*/ SelectdCompletionBlock:^(MenuLabel *menuLabel, NSInteger index) {
        NSLog(@"index:%ld ItmeNmae:%@",index,menuLabel.title);
    }];
}


@end
