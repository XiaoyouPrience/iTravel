//
//  XYStatusCell.m
//  iTravel
//
//  Created by XiaoYou on 16/4/3.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYStatusCell.h"
#import "XYStatus.h"
#import "XYStatusFrame.h"
#import "XYUser.h"
#import "UIImageView+WebCache.h"

@interface XYStatusCell()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
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

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;
@end

@implementation XYStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    XYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XYStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resiedImageWithName:@"timeline_card_top_background"];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = XYStatusNameFont;
//    nameLabel.textColor = XYColor(240, 140, 19);
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = XYStatusTimeFont;
    timeLabel.textColor = XYColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = XYStatusSourceFont;
    sourceLabel.textColor = XYColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = XYStatusContentFont;
    contentLabel.textColor = XYColor(39, 39, 39);
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resiedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.textColor = XYColor(67, 107, 163);
    retweetNameLabel.backgroundColor =[UIColor clearColor];
    retweetNameLabel.font = XYRetweetStatusNameFont;
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.textColor = XYColor(90, 90, 90);
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.font = XYRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 1.微博的工具条 */
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    statusToolbar.image = [UIImage imageWithName:@"timeline_card_bottom_background"];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截tableView设置cell的frame
 */
- (void)setFrame:(CGRect)frame
{
    // 拦截cell重新设置frame
    frame.origin.x = XYStatusTableBorder;
    frame.origin.y += XYStatusTableBorder;
    frame.size.width -= 2 * XYStatusTableBorder;
    frame.size.height -= XYStatusTableBorder;
    
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(XYStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.设置工具条
    [self setupStatusToolBarFrame];
}


- (void)setupStatusToolBarFrame
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}

/**
 *  原创微博
 */
- (void)setupOriginalData
{
    XYStatus *status = self.statusFrame.status;
    XYUser *user = status.user;
    
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    
    // 6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }
}

/**
 *  被转发微博
 */
- (void)setupRetweetData
{
    XYStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    XYUser *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
