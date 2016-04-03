//
//  UIImage+XY.h
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XY)
/**
 *  返回一张适配后的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resiedImageWithName:(NSString *)name;

+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top;

@end
