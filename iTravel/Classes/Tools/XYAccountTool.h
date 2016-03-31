//
//  XYAccountTool.h
//  iTravel
//
//  Created by XiaoYou on 16/4/1.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYAccount;

@interface XYAccountTool : NSObject

/**
 *  存储账号信息
 */
+ (void)saveAccount:(XYAccount *)account;

/**
 *  取出账号信息 
 */
+ (XYAccount *)account;

@end
