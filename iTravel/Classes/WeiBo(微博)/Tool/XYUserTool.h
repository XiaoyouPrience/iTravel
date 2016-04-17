//
//  XYUserTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//
//  请求用户数据的业务处理类

#import <Foundation/Foundation.h>

#import "XYUserInfoParam.h"
#import "XYUserInfoResult.h"

#import "XYUserUnreadCountParam.h"
#import "XYUserUnreadCountResult.h"
@interface XYUserTool : NSObject

/**
 *  请求用户信息
 *
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userInfoWirhParam:(XYUserInfoParam *)param success:(void (^)(XYUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  请求用户未读数
 *
 *  @param param   请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)userUnreadMessageCountWithParam:(XYUserUnreadCountParam *)param success:(void(^)(XYUserUnreadCountResult *result))success failure:(void(^)(NSError *error))failure;
@end
