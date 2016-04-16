//
//  XYHomeStatusesResult.h
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface XYHomeStatusesResult : NSObject

/**
 *  statuses数组里面放的都是IWStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;

@end
