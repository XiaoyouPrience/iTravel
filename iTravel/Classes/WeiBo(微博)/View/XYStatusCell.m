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
#import "UIImage+XY.h"
#import "XYStatuaToolBar.h"
#import "XYStatusTopView.h"

@interface XYStatusCell()
/** 顶部的view */
@property (nonatomic, weak) XYStatusTopView *topView;
/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) XYStatuaToolBar *statusToolBar;
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
    /* cell 的选中背景，*/
    UIView *bgView = [[UIView alloc] init];
    self.selectedBackgroundView = bgView;
    
    /** 1.顶部的view */
    XYStatusTopView *topView = [[XYStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;    
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
    XYStatuaToolBar *statusToolbar = [[XYStatuaToolBar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolBar = statusToolbar;
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

/**
 *  微博底部工具条
 */
- (void)setupStatusToolBarFrame
{
    self.statusToolBar.frame = self.statusFrame.statusToolbarF;
    self.statusToolBar.status = self.statusFrame.status;

}

/**
 *  原创微博
 */
- (void)setupOriginalData
{
    self.topView.statusFrame = self.statusFrame;
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
//        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}

@end
