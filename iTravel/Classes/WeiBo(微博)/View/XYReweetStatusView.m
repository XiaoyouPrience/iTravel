//
//  XYReweetStatusView.m
//  iTravel
//
//  Created by XiaoYou on 16/4/4.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYReweetStatusView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "UIImageView+WebCache.h"
#import "XYPhoto.h"
#import "XYPhotosView.h"

@interface XYReweetStatusView ()

/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) XYPhotosView *retweetPhotoView;


@end
@implementation XYReweetStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // TODO:init
        // 用户交互开启
        self.userInteractionEnabled = YES;
        
        // 0. 设置自己背景
        self.image = [UIImage resiedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        /** 1.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.textColor = XYColor(67, 107, 163);
        retweetNameLabel.backgroundColor =[UIColor clearColor];
        retweetNameLabel.font = XYRetweetStatusNameFont;
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 2.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.textColor = XYColor(90, 90, 90);
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.font = XYRetweetStatusContentFont;
        retweetContentLabel.numberOfLines = 0;
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 3.被转发微博的配图 */
        XYPhotosView *retweetPhotoView = [[XYPhotosView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;

    }
    return self;
}

/**
 *  重写自己的set方法，赋值数据和frame
 */
- (void)setStatusFrame:(XYStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XYStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    XYUser *user = retweetStatus.user;

    // 1.父控件
    if (retweetStatus) {
        self.hidden = NO;
        self.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        //        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            
            // 暂时显示第一张tu
//            XYPhoto *photo = retweetStatus.pic_urls[0];
//            NSString *url = photo.thumbnail_pic;
//            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
            self.retweetPhotoView.photos = retweetStatus.pic_urls;
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.hidden = YES;
    }

    
}

@end
