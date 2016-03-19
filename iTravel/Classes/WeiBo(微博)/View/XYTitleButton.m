//
//  XYTitleButton.m
//  iTravel
//
//  Created by XiaoYou on 16/3/19.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTitleButton.h"

#define k_imageW 30

@implementation XYTitleButton


/**
 *  快速返回一个titleButton ，返回默认样式的titleButton
 */
+ (instancetype)titleButton
{
   return [[self alloc] init];
}

/**
 *  快速返回一个自定义的titleButton
 *
 *  @param iconName 图片名称
 *  @param title    按钮文字
 *  @param bgImage  背景图片
 *  @param frame    按钮frame
 *  @param target   目标
 *  @param action   事件
 */
+ (instancetype)titleButtonWithIcon:(NSString *)iconName title:(NSString *)title backgroundImage:(NSString *)bgImage frame:(CGRect)frame target:(id)target action:(SEL)action
{
    XYTitleButton *titleBtn = [XYTitleButton titleButton];
    
    // 创建内部子空间
    // 1.图标 -- 默认是这个向下箭头，外部可以自己重新设置
    [titleBtn setImage:[UIImage imageWithName:iconName] forState:UIControlStateNormal];
    titleBtn.adjustsImageWhenHighlighted = NO; // 不要自动调整高亮时候图片
    titleBtn.imageView.contentMode = UIViewContentModeCenter;
    
    // 2.文字
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    // 按钮文字也是默认值
    [titleBtn setTitle:title forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    // 3.背景色 -- ios7之后扁平化，只需设置高亮时候的背景图片
    [titleBtn setBackgroundImage:[UIImage resiedImageWithName:bgImage] forState:UIControlStateHighlighted];
    
    // 4. 设置位置信息 -- 这个是默认值（外面可以重新设置）
    titleBtn.frame = frame;
    
    // 5. 添加事件
    [titleBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return titleBtn;
}

/**
 *  对象方法返回一个titleButton
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 创建内部子空间
        // 1.图标 -- 默认是这个向下箭头，外部可以自己重新设置
        [self setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO; // 不要自动调整高亮时候图片
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 2.文字
        self.titleLabel.font = [UIFont systemFontOfSize:20];
        // 按钮文字也是默认值
        [self setTitle:@"我的微博" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        // 3.背景色 -- ios7之后扁平化，只需设置高亮时候的背景图片
        [self setBackgroundImage:[UIImage resiedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        // 4. 设置位置信息 -- 这个是默认值（外面可以重新设置）
        self.frame = CGRectMake(0, 0, 100, 40);
    }
    return self;
}

/**
 *  重写按钮内部组件的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = k_imageW;
    CGFloat imageX = self.frame.size.width - imageW;
    CGFloat imageH = self.frame.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}
/**
 *  重写按钮内部组件的frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width - k_imageW;
    CGFloat titleX = 0;
    CGFloat titleH = self.frame.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}


@end
