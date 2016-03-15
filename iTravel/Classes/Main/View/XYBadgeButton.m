//
//  XYBadgeButton.m
//  iTravel
//
//  Created by XiaoYou on 16/3/16.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYBadgeButton.h"

@implementation XYBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage resiedImageWithName:@"main_badge"] forState:UIControlStateNormal];

    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    // 字符串赋值用copy
    _badgeValue = [badgeValue copy];
    
    
    if (self.badgeValue) {
        
        // 有值的时候显示
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 通过item设置内部 badgeButton
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (self.badgeValue.length > 1) {
            
            CGSize badgeSize = [self.badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = self.currentBackgroundImage.size.width + 15;
        }
        
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        // 设置自己的frame
        self.frame = frame;
        
//        self.badgeButton.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    }else
    {
        self.self.hidden = YES;
    }
    
    
}

@end
