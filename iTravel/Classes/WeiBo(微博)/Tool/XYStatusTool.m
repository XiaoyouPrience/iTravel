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

@implementation XYStatusTool

+ (void)homeStatusesWithParam:(XYHomeStatusesParam *)param success:(void (^)(XYHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
        [XYHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            if (success) {
                
                // 将返回的字典数据封装成 XYHomeStatusesResult 再进行返回
                XYHomeStatusesResult *result = [XYHomeStatusesResult objectWithKeyValues:json];
                
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
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
