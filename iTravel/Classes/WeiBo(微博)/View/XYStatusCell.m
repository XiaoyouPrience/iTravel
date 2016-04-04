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
        
        // 2.添加微博的工具条
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
    self.backgroundColor = [UIColor clearColor]; //设置cell自己的背景为透明
    
    /** 1.顶部的view */
    XYStatusTopView *topView = [[XYStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;    
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

@end
