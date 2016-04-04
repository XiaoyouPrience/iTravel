//
//  XYStatuaToolBar.h
//  iTravel
//
//  Created by XiaoYou on 16/4/4.
//  Copyright © 2016年 XY. All rights reserved.
//  cell底部的工具条

#import <UIKit/UIKit.h>
@class XYStatus;

@interface XYStatuaToolBar : UIImageView
// 自己内部的微博数据
@property (nonatomic, strong)XYStatus *status;

@end
