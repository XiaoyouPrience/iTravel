//
//  UIBarButtonItem+XY.h
//  iTravel
//
//  Created by XiaoYou on 16/3/19.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XY)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

@end
