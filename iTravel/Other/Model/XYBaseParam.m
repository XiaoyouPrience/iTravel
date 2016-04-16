//
//  XYBaseParam.m
//  iTravel
//
//  Created by XiaoYou on 16/4/16.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYBaseParam.h"
#import "XYAccountTool.h"
#import "XYAccount.h"

@implementation XYBaseParam

- (id)init
{
    if (self = [super init]) {
        self.access_token = [XYAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

@end
