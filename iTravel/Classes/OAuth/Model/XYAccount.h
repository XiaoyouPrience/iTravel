//
//  XYAccount.h
//  iTravel
//
//  Created by XiaoYou on 16/4/1.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAccount : NSObject <NSCoding>

@property (nonatomic, copy)NSString *access_token;
// access_token 的过期时间
@property (nonatomic, strong)NSDate *expires_time;
// 比较大的数字用 long long 比较好
@property(nonatomic, assign) long long expires_in;
@property(nonatomic, assign) long long remind_in;
@property(nonatomic, assign) long long uid;

/**每次授权时候用户的昵称*/
@property (nonatomic, copy)NSString *name;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
