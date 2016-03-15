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

@property (nonatomic,weak) XYTabbarButton *selectButton;

@end

@implementation XYTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化代码
        
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_backGround"]];
        }
        
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
    // 创建按钮
    XYTabbarButton *button = [[XYTabbarButton alloc] init];
    [self addSubview:button];
    
    // 设置数据
    button.item = item;
    
    // 监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 设置默认点击第一个,判断添加到第一个按钮时，长度为1
    if (self.subviews.count == 1) {
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
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int index = 0; index < self.subviews.count; index ++) {
        // 取出按钮
        XYTabbarButton *button = self.subviews[index];
    
        // 设置按钮的frame
        CGFloat buttonX = index * buttonW;
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        
        // 绑定tag
        button.tag = index;
    }
}

@end
