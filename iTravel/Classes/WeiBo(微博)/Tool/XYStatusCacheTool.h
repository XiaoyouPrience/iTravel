//
//  XYStatusCacheTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYHomeStatusesParam.h"


@interface XYStatusCacheTool : NSObject


/**
 *  缓存一条微博
 *
 *  @param dict 需要缓存的微博数据
 */
+ (void)addStatus:(NSDictionary *)dict;

/**
 *  缓存N条微博
 *
 *  @param dictArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)dictArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 字典数组
 */
+ (NSArray *)statuesWithParam:(XYHomeStatusesParam *)param;

@end
