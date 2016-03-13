//
//  XYTabbarButton.m
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

// 图标的比例
#define XYTabbarButtonImageRatio 0.6
// 按钮的默认文字颜色
#define  XYTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  XYTabBarButtonTitleSelectedColor (iOS7 ? XYColor(234, 103, 7) : XYColor(248, 139, 0))

#import "XYTabbarButton.h"

@interface XYTabbarButton()



@end

@implementation XYTabbarButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 初始化设置
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:XYTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:XYTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        if (!iOS7) {
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    /**
     *  取消点击高亮状态
     */
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat iamgeX = 0;
    CGFloat iamgeY = 0;
    CGFloat iamgeW = self.frame.size.width;
    CGFloat iamgeH = self.frame.size.height * XYTabbarButtonImageRatio;
    
    return CGRectMake(iamgeX, iamgeY, iamgeW, iamgeH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = self.frame.size.height * XYTabbarButtonImageRatio;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height - titleY;
    
    return CGRectMake(titleX , titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
}

@end
