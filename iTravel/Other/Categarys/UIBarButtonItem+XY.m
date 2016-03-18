//
//  UIBarButtonItem+XY.m
//  iTravel
//
//  Created by XiaoYou on 16/3/19.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UIBarButtonItem+XY.h"

@implementation UIBarButtonItem (XY)

/**
 *  快速返回一个barButtonItem
 *
 *  @param icon          icon
 *  @param highlightIcon 高亮时候icon
 *  @param target        target
 *  @param action        action
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highlightIcon] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.currentBackgroundImage.size.width, button.currentBackgroundImage.size.height);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
