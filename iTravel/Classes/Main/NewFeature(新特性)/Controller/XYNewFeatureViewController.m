//
//  XYNewFeatureViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/30.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYNewFeatureViewController.h"
#import "XYTabBarViewController.h"
#define NewFeatureImageCount 3

@interface XYNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation XYNewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 加载ScrollView
    [self setupScrollView];
    
    // 加载pageControl
    [self setupPageControl];

}

/**
 *  添加pageContrl
 */
- (void)setupPageControl
{
    // 1. 添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NewFeatureImageCount;
    pageControl.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 30);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    // 2. 设置圆点颜色
    pageControl.currentPageIndicatorTintColor = XYColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = XYColor(189, 189, 189);
}

/**
 *  添加ScrollView
 */
- (void)setupScrollView
{
    // 1.创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.创建图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < NewFeatureImageCount; index++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        imageView.image = [UIImage imageWithName:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        
        // 最后一张上面添加一个按钮
        if (index == NewFeatureImageCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * NewFeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

/**
 *  给最后一样NewFeatureImage添加一个进入按钮
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0. imageView 能进行交互
    imageView.userInteractionEnabled = YES;
    
    // 1. 添加开始按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startBtn.center = CGPointMake(centerX, centerY);
    startBtn.bounds = CGRectMake(0, 0, 150, 50);
    
    // 3.设置文字
    [startBtn setTitle:@"Come on !!" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startApp) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    // 4.添加checkBox
    UIButton *checkBox = [[UIButton alloc] init];
    checkBox.selected = YES;   // 默认选中状态
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkBox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkBoxCenterX = centerX;
    CGFloat checkBoxCenterY = imageView.frame.size.height * 0.5;
    checkBox.center = CGPointMake(checkBoxCenterX, checkBoxCenterY);
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkBox];
}

- (void)startApp
{
    // 切换控制器
    self.view.window.rootViewController = [[XYTabBarViewController alloc] init];
}

- (void)checkBoxClick:(UIButton *)checkBox
{
    checkBox.selected = !checkBox.isSelected;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1. 取出水平上的滚动距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2. 求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

@end
