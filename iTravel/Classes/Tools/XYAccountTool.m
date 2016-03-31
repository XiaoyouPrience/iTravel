//
//  XYAccountTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/1.
//  Copyright © 2016年 XY. All rights reserved.
//  账号管理工具类 -- 目前缺陷只能存储一个账号
//  存储多个账号思路 -- 可以把存过的账号放进数组中存进去

#import "XYAccountTool.h"
#import "XYAccount.h"

#define AccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation XYAccountTool

/**存储账号信息*/
+ (void)saveAccount:(XYAccount *)account
{
//    1.存储路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    
    NSDate *date = [NSDate date];
    account.expires_time = [date dateByAddingTimeInterval:account.expires_in];
    
    // 2.归档
    [NSKeyedArchiver archiveRootObject:account toFile:AccountFilePath];
}
/**获取账号信息*/
+ (XYAccount *)account
{
    // 取出 account
    XYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFilePath];
    
    // 判断是否过期
    // NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ([account.expires_time compare:[NSDate date]] == NSOrderedAscending) {
        // 没有过期
        return account;
    }else
    {
        // 这里可以提示一下倒是。
        return nil;
    }
    
}

@end
