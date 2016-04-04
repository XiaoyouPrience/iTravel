//
//  XYPhotosView.h
//  iTravel
//
//  Created by XiaoYou on 16/4/5.
//  Copyright © 2016年 XY. All rights reserved.
//  微博的photo视图，--图片浏览

#import <UIKit/UIKit.h>
@interface XYPhotosView : UIImageView
/**
 *  需要展示的图片(数组里面装的都是XYPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;


@end
