//
//  XYComposePhotosView.h
//  iTravel
//
//  Created by XiaoYou on 16/4/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYComposePhotosView : UIView

/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;

@end
