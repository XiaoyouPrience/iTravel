//
//  XYTabbar.m
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTabbar.h"

@implementation XYTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化代码
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
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    
    // 设置数据
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
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
        UIButton *button = self.subviews[index];
    
        // 设置按钮的frame
        CGFloat buttonX = index * buttonW;
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    }
}

@end
