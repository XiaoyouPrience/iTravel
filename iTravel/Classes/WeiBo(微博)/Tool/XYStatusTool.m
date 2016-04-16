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

+ (void)homeStatusesWithParam:(XYHomeStatusesParam *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
        [XYHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            if (success) {
                success(json);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
}

@end
