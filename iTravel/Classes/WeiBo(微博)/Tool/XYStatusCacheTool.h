//
//  XYStatusCacheTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/18.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYHomeStatusesParam.h"
@class XYStatus;  // 缓存要面向模型


@interface XYStatusCacheTool : NSObject


/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(XYStatus *)status;

/**
 *  缓存N条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParam:(XYHomeStatusesParam *)param;

@end
