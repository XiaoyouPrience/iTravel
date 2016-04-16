//
//  XYHomeStatusesResult.m
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYHomeStatusesResult.h"
#import "MJExtension.h"
#import "XYStatus.h"


@implementation XYHomeStatusesResult

// 告诉自己 Statuses这个数组中存的是XYtatus 这样类型的参数
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [XYStatus class]};
}

@end
