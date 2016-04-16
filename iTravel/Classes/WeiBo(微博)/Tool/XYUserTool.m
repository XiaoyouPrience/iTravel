//
//  XYUserTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYUserTool.h"
#import "XYHttpTool.h"
#import "MJExtension.h"

@implementation XYUserTool

+ (void)userInfoWirhParam:(XYUserInfoParam *)param success:(void (^)(XYUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    // 发送请求之前需要把传入的请求参数模型转换为字典
    [XYHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        
        if (success) {
            
            // 因为要返回的数据是XYUserInfoResult * 所以要对返回数据进行封装
            XYUserInfoResult *result = [XYUserInfoResult objectWithKeyValues:json];
            
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
