//
//  XYHomeStatusesParam.m
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//
//  封装加载首页微博数据的参数

#import "XYHomeStatusesParam.h"

@implementation XYHomeStatusesParam

/**
 * 封装返回请求数据条数
 *
 *  @return 请求count 数目
 */
- (NSNumber *)count
{
    // 有多少返回多少，默认20
    return _count ? _count : @20;
}

@end
