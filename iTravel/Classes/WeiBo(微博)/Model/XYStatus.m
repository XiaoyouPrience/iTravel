//
//  XYStatus.m
//  iTravel
//
//  Created by XiaoYou on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYStatus.h"
#import "NSDate+XY.h"
#import "MJExtension.h"
#import "XYPhoto.h"

@implementation XYStatus


#pragma mark - 偷偷告诉框架pic_urls 内部要装什么模型
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[XYPhoto class]};
}

#pragma mark -   其实用MJExtation 这些方法就不用写了
// 其实用MJExtation 这些方法就不用写了
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 防止崩溃
}


#pragma mark - 这段必须重写，时间是每次需要计算有不同的显示的。
// 重写时间的Get方法 -- 这里重写以后一定要注意能正常成功返回
- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    DLog(@"%@",_created_at);
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];  // 英文
    
//    NSDate *createdDate = [fmt dateFromString:@"周一 4月 04 15:39:08 +0800 2016"];   中文
    
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if ([createdDate isToday]) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if ([createdDate isYesterday]) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if ([createdDate isThisYear]) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

#pragma mark - 这段必须重写，来源是固定的，只需要计算一次，所以重写set方法之后赋值给成员变量，在外面调用get方法的时候就是固定的了。这样避免了每次都计算，提升了性能，好好学习点，
- (void)setSource:(NSString *)source
{
    // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    DLog(@"%@",source);
    if (source.length) {
        unsigned long loc = [source rangeOfString:@">"].location + 1;
        unsigned long length = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
        
        _source = [NSString stringWithFormat:@"来自%@", source];
        NSLog(@"----setSource--%@", _source);
    }else
    {
        _source = [NSString stringWithFormat:@"来自未知应用。"];
    }
    
}

//- (void)setCreated_at:(NSString *)created_at
//{
//    
//}

@end
