//
//  XYStatuaToolBar.m
//  iTravel
//
//  Created by XiaoYou on 16/4/4.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYStatuaToolBar.h"
#import "XYStatus.h"

@interface XYStatuaToolBar()
/**按钮数组*/
@property (nonatomic, strong)NSMutableArray *btns;
/**分割线数组*/
@property (nonatomic, strong)NSMutableArray *dividers;

/**转发按钮*/
@property (nonatomic,weak) UIButton *reweetBtn;
/**评论按钮*/
@property (nonatomic,weak) UIButton *commentBtn;
/**赞*/
@property (nonatomic,weak) UIButton *attitudeBtn;

@end
@implementation XYStatuaToolBar


/**懒加载数组*/
- (NSMutableArray *)btns
{
    if(_btns == nil)
    {
        _btns = [[NSMutableArray alloc]init];
    }
    return _btns;
}
- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 0. 设置自己可和用户交互
        self.userInteractionEnabled = YES;
        // 1.设置自己内部背景
        self.image = [UIImage resiedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resiedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        // 2.添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        // 3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 *  创建工具条上的按钮
 *
 *  @param title   按钮文字
 *  @param image   图片
 *  @param bgImage 背景图片
 *
 *  @return 返回一个工具条按钮
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    // 1.创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    // 2.添加到数组中
    [self.btns addObject:button];
    
    return button;
}
/**
 *  设置工具条的分割线
 */
- (void)setupDivider
{
    // 1.创建分割线图片
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    // 2.添加到工具条的数组中
    [self.dividers addObject:divider];
}

/**
 *  给子控件布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    unsigned long dividerCount = self.dividers.count; // 分割线个数
    CGFloat dividerW = 2; // 分割线宽度
    
    unsigned long btnCount = self.btns.count;
    CGFloat btnW = (self.frame.size.width - dividerCount * dividerW) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY= 0;
    for (int i = 0 ;i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        // 设置frame
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 2. 设置分割线frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        
        // 设置frame
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}


/**
 *  重写set方法，数据的赋值
 */
- (void)setStatus:(XYStatus *)status
{
    _status = status;
    
    // 1.设置转发数
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
    
}
/**
 *  设置按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(显示的数字为0的时候, 显示这个原始标题)
 *  @param count         显示的个数
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    
    if (count) { // 个数不为0
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // >= 1W
            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
            // double countDouble = count / 1000 * 0.1;
            
            // 42342 / 10000.0 = 4.2342
            // 10742 / 10000.0 = 1.0742
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // title == 4.2万 4.0万 1.0万 1.1万
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}

@end
