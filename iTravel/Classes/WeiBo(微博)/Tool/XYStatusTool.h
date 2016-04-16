//
//  XYStatusTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//  业务处理类

#import <Foundation/Foundation.h>
@class XYHomeStatusesParam;

@interface XYStatusTool : NSObject

/**
 *  微博首页加载微博的业务处理类方法
 *
 *  @param param   微博加载请求参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)homeStatusesWithParam:(XYHomeStatusesParam *)param success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end
