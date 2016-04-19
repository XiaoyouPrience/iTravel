//
//  XYStatusTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//  微博的业务工具类 --- 专门为微博 模块服务

#import "XYStatusTool.h"
#import "XYHttpTool.h"
#import "MJExtension.h"
#import "XYHomeStatusesParam.h"
#import "XYStatusCacheTool.h"

@implementation XYStatusTool

/**
 *  请求用户首页微博数据
 *  根据缓存机制，先查询是否有缓存再进行联网拉取数据
 */
+ (void)homeStatusesWithParam:(XYHomeStatusesParam *)param success:(void (^)(XYHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    // 1.先从缓存中加载
    NSArray *statusArray = [XYStatusCacheTool statuesWithParam:param];
    if (statusArray.count) {
        
        // 传递成功回调block
        if (success) {
            XYHomeStatusesResult *result = [[XYHomeStatusesResult alloc] init];
            
            // 封装返回结果 -- 用缓存中找到的数据DictArray
            result.statuses = statusArray;
//            result.statuses = [XYStatus objectArrayWithKeyValuesArray:statusArray];
            
            success(result);
        }
        
    }else
    {// 2.缓存中没有数据才联网加载
        [XYHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
   
#warning 这里必须先缓存再进行回调block。
            // 将返回的字典数据封装成 XYHomeStatusesResult 再进行返回
            XYHomeStatusesResult *result = [XYHomeStatusesResult objectWithKeyValues:json];
            // 拉取新数据先做缓存，存到本地数据库
            [XYStatusCacheTool addStatuses:result.statuses];
            
            if (success) {
                // 调用成功回到进行返回
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}


+ (void)sendStatusWithParam:(XYSendStatusParam *)param success:(void (^)(XYSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [XYHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        
        if (success) {
            XYSendStatusResult *result = [XYSendStatusResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
