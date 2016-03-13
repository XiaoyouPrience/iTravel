//
//  XYTabbar.h
//  iTravel
//
//  Created by XiaoYou on 16/3/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTabbar;
@protocol XYTabbarDelegate <NSObject>

@optional
- (void)tabBar:(XYTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end

@interface XYTabbar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic,weak) id<XYTabbarDelegate> delegate;

@end
