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
@property(nonatomic, assign) long long expires_in;
@property(nonatomic, assign) long long remind_in;
@property(nonatomic, assign) long long uid;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
