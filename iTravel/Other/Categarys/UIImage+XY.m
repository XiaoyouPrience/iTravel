//
//  UIImage+XY.m
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UIImage+XY.h"

@implementation UIImage (XY)

+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        // 如果是iOS7 拼接图片
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        
        if (image == nil) {
            // 如果没有 iOS7 的图片就用原来图片名
            image = [UIImage imageNamed:name];
        }
        // 返回该图片
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resiedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
