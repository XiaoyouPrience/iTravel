//
//  XYStatusTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//  业务处理类

#import <Foundation/Foundation.h>

#import "XYHomeStatusesParam.h"
#import "XYHomeStatusesResult.h"
#import "XYSendStatusParam.h"
#import "XYSendStatusResult.h"

@interface XYStatusTool : NSObject

/**
 *  微博首页加载微博数据
 *
 *  @param param   微博加载请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)homeStatusesWithParam:(XYHomeStatusesParam *)param success:(void(^)(XYHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一条微博
 *
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendStatusWithParam:(XYSendStatusParam *)param success:(void (^)(XYSendStatusResult * result))success failure:(void (^)(NSError *error))failure;
@end
