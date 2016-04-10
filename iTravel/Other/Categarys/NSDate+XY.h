//
//  NSDate+XY.h
//  iTravel
//
//  Created by XiaoYou on 16/4/4.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XY)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  返回一个只有YMD的时间
 */
- (NSDate *)dateWithYMD;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

@end
