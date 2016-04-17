//
//  XYUserUnreadCountResult.m
//  iTravel
//
//  Created by XiaoYou on 16/4/17.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYUserUnreadCountResult.h"

@implementation XYUserUnreadCountResult

- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
