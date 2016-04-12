//
//  NSString+Extension.m
//  
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andTag:(int)tag
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize sizeWant = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    if(tag == 1){
        if(sizeWant.width > 100){
            return CGSizeMake(100, sizeWant.height);
        }else{
            return sizeWant;
        }
            }else{
                return sizeWant;
            }
}


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithMyAttributes;
{
    
//    NSDictionary *attributes=@{NSFontAttributeName:font};
//    CGSize fontSize=CGSizeMake(MAXFLOAT, MAXFLOAT);
//   return [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self,attributes, fontSize]];
    return CGSizeZero;
}

- (CGSize)boundingRectWithMySize:(UIFont *)font
{

    NSDictionary *attributes=@{NSFontAttributeName:font};
    CGSize fontSize=CGSizeMake(MAXFLOAT, MAXFLOAT);
    return [self boundingRectWithSize:fontSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}



#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (self == nil || self.length == 0);
}

#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)randomPassword
{
    //自动生成8位随机密码
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSLog(@"now:%.8f",random);
    NSString *randomString = [NSString stringWithFormat:@"%.16f",random];
    NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    NSLog(@"randompassword:%@",randompassword);
    
    return randompassword;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}



@end
