//
//  XYUserUnreadCountParam.h
//  iTravel
//
//  Created by XiaoYou on 16/4/17.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYBaseParam.h"

@interface XYUserUnreadCountParam : XYBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

@end
