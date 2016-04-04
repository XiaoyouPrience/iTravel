//
//  XYStatusTopView.m
//  iTravel
//
//  Created by XiaoYou on 16/4/4.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYStatusTopView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "UIImageView+WebCache.h"

@interface XYStatusTopView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

@end
@implementation XYStatusTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        
        // 0. 设置自己的背景se
        self.image = [UIImage resiedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resiedImageWithName:@"timeline_card_top_background_highlighted"];
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = XYStatusNameFont;
        //    nameLabel.textColor = XYColor(240, 140, 19);
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = XYStatusTimeFont;
        timeLabel.textColor = XYColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = XYStatusSourceFont;
        sourceLabel.textColor = XYColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.font = XYStatusContentFont;
        contentLabel.textColor = XYColor(39, 39, 39);
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;

    }
    return self;
}

- (void)setStatusFrame:(XYStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XYStatus *status = statusFrame.status;
    XYUser *user = status.user;
    
    // 1.topView
    self.frame = self.statusFrame.topViewF;
    
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    //    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    // 5.时间 -- 需要每次都计算frame
    self.timeLabel.text = status.created_at;
    //    self.timeLabel.frame = self.statusFrame.timeLabelF;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + XYStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:XYStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    // 6.来源 -- 这个由于是固定只写一次就好，直接用set方法写好，现在直接用就行
    self.sourceLabel.text = status.source;
    //    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    CGFloat sourceLabelX = CGRectGetMaxX(self.statusFrame.timeLabelF) + XYStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:XYStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }

    
}


@end
