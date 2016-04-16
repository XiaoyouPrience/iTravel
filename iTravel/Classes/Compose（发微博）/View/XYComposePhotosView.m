//
//  XYComposePhotosView.m
//  iTravel
//
//  Created by XiaoYou on 16/4/14.
//  Copyright © 2016年 XY. All rights reserved.
//  自定制的发微博时候添加选择完后的图片的View ---> superView是XYtextView

#import "XYComposePhotosView.h"

@implementation XYComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化方法
    }
    return self;
}

/**
 *  添加图片
 */
- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:image];
    [self addSubview:imageView];
}

/**
 *  对内部子控件布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    unsigned long count = self.subviews.count;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 4; // 设置每行最大列数
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);  // 计算图片之间间距
    
    // 创建ImageView并且布局
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

/**
 *  返回所有图片
 */
- (NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    return images;
}

@end
