//
//  XYSearchBar.m
//  iTravel
//
//  Created by XiaoYou on 16/3/19.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSearchBar.h"

@implementation XYSearchBar

/**
 *  快速返回一个自定义的searchBar
 */
+ (XYSearchBar *)searchBar
{
   return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat margin = 20;
        // 搜索栏frame -- 默认
        self.frame = CGRectMake(0, 0, ScreenW - 2*margin , 30);
        
        // 搜索栏背景颜色
        self.background = [UIImage resiedImageWithName:@"searchbar_textfield_background"];
        
        // 搜索栏 放大镜图标（左视图）
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        // 子控件的位置 需要在layoutSubViews中去写
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提示文字
        //    searchBar.placeholder = @"搜索";
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"索索" attributes:attrs];
        
    }
    return self;
}

// 在这里才能真正设置子控件的frame -- 否则是没有子控件的
- (void)layoutSubviews
{
    //必须要重写父类的方法
    [super layoutSubviews];
    
    // 此刻才能确定自己真正的frame。
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
}

@end
