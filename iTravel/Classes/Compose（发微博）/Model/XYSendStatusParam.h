//
//  XYSendStatusParam.h
//  iTravel
//
//  Created by XiaoYou on 16/4/17.
//  Copyright © 2016年 XY. All rights reserved.
//
//  封装发微博的参数

#import <Foundation/Foundation.h>
#import "XYBaseParam.h"

@interface XYSendStatusParam :XYBaseParam


/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;

@end
