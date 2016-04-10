//
//  XYUser.h
//  iTravel
//
//  Created by XiaoYou on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型 > 2 会员
 */
@property (nonatomic, assign) int mbtype;

@end
