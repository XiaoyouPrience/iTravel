//
//  XYTabbar.m
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTabbar.h"
#import "XYTabbarButton.h"

@interface XYTabbar ()

@property (nonatomic,strong) NSMutableArray *tabBarButtons;

@property (nonatomic,weak) XYTabbarButton *selectButton;

@property (nonatomic,weak) UIButton *plusButton;

@end

@implementation XYTabbar

/**
 *  这个数组只需要一次，直接懒加载
 */
- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [[NSMutableArray alloc] init];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化代码
        
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_backGround"]];
        }
        
        // 添加一个中间的加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button" ]forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:plusButton];
        plusButton.frame = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        self.plusButton = plusButton;
        
    }
    return self;
}

/**
 *  添加Tabbar上的按钮
 *
 *  @param item tabbarItem
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    XYTabbarButton *button = [[XYTabbarButton alloc] init];
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.设置默认点击第一个,判断添加到第一个按钮时，长度为1
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(XYTabbarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectButton.tag to:button.tag];
    }
    
    
    // 设置按钮点击三部曲
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}


/**
 *  重新布局子空间（button）
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.加号按钮
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w *0.5, h *0.5);
    
    // 2.重新布局所有按钮
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int index = 0; index < self.tabBarButtons.count; index ++) {
        // 取出按钮
        XYTabbarButton *button = self.tabBarButtons[index];
    
        // 设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX = index * buttonW + buttonW;
        }
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        
        // 绑定tag
        button.tag = index;
    }
}

@end
