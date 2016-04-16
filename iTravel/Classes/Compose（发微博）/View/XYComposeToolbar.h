//
//  XYComposeToolbar.h
//  iTravel
//
//  Created by XiaoYou on 16/4/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYComposeToolbar;

typedef enum {
    XYComposeToolbarButtonTypeCamera,
    XYComposeToolbarButtonTypePicture,
    XYComposeToolbarButtonTypeMention,
    XYComposeToolbarButtonTypeTrend,
    XYComposeToolbarButtonTypeEmotion
}XYComposeToolbarButtonType;

@protocol XYComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(XYComposeToolbar*)toolbar didClickedButton:(XYComposeToolbarButtonType)buttonType;

@end

@interface XYComposeToolbar : UIView

@property (nonatomic,weak) id<XYComposeToolbarDelegate> delegate;

@end
