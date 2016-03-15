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
#import "XYBadgeButton.h"

@interface XYTabbarButton()

@property (nonatomic,weak) XYBadgeButton *badgeButton;

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
        
        // 内部badgeButton
        XYBadgeButton *badgeButton = [[XYBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
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
    
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    // 第一次主动调用一下
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

/* 移除观察者*/
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 赋值，显示自己的 badgeValue
    self.badgeButton.badgeValue = self.item.badgeValue;
    // 设置badgeButton 的位置
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 5;
    CGFloat badgeY = 5;
    CGRect badgeF =  self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

@end
