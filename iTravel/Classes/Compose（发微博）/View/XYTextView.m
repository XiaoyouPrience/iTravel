//
//  XYTextView.m
//  iTravel
//
//  Created by XiaoYou on 16/4/12.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYTextView.h"
#import "NSString+Extension.h"

@interface XYTextView ()
@property (nonatomic,weak) UILabel *placeholderLabel;
@end

@implementation XYTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // todo
        // 1.添加提示文字
        UILabel *placeholderLabel = [[UILabel alloc] init];
//        placeholderLabel.text = @"分享你此刻的心情...";
        placeholderLabel.textColor = [UIColor yellowColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font = self.font;
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;
        
        // 2.监听textView文字改变的通知
        [kNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) { // 需要显示
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;

        CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font maxSize:CGSizeMake(maxW, maxH)];
        
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);

    } else {
        self.placeholderLabel.hidden = YES;
    }
    //    self.placeholderLabel.hidden = (placeholder.length == 0);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}


@end
