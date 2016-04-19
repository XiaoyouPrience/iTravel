//
//  XYStatusCacheTool.m
//  iTravel
//
//  Created by XiaoYou on 16/4/18.
//  Copyright © 2016年 XY. All rights reserved.
//
//  管理微博的缓存数据


#import "XYStatusCacheTool.h"
#import "XYAccountTool.h"
#import "XYAccount.h"
#import "FMDB.h"
#import "XYStatus.h" //导入模型头文件


@implementation XYStatusCacheTool

// 声明一个只有本文件能用的数据库全局队列
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, status blob);"];
    }];
}

+ (void)addStatuses:(NSArray *)statusArray
{
    for (XYStatus *status in statusArray) {
        [self addStatus:status];
    }
}

+ (void)addStatus:(XYStatus *)status
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *accessToken = [XYAccountTool account].access_token;
        NSString *idstr = status.idstr;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];  // 这里的意思是Status必须实现Coding协议
        
        // 2.存储数据
        BOOL isSuccess = [db executeUpdate:@"insert into t_status (access_token, idstr, status) values(?, ? , ?)", accessToken, idstr, data];
        if (isSuccess) {
            DLog(@"保存成功");
        }
    }];
}

+ (NSArray *)statuesWithParam:(XYHomeStatusesParam *)param
{
    // 1.定义数组
    __block NSMutableArray *statusArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        statusArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [XYAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) { // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"status"];
            XYStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:status];
        }
    }];
    
    // 3.返回数据
    return statusArray;
}


@end
