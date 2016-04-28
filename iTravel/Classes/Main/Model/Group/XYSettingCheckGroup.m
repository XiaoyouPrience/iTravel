//
//  XYSettingCheckGroup.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingCheckGroup.h"
#import "XYSettingCheckItem.h"
#import "XYSettingLabelItem.h"

@implementation XYSettingCheckGroup

- (XYSettingCheckItem *)checkedItem
{
    for (XYSettingCheckItem *item in self.items) {
        if (item.isChecked) return item;
    }
    return nil;
}

- (void)setCheckedItem:(XYSettingCheckItem *)checkedItem
{
    for (XYSettingCheckItem *item in self.items) {
        item.checked = (item == checkedItem);
    }
    self.sourceItem.text = checkedItem.title;
}

- (int)checkedIndex
{
    XYSettingCheckItem *item = self.checkedItem;
    return item ? [self.items indexOfObject:item] : -1;
}

- (void)setCheckedIndex:(int)checkedIndex
{
    if (checkedIndex <0 || checkedIndex >= self.items.count) return;
    
    self.checkedItem = self.items[checkedIndex];
}

- (void)setItems:(NSArray *)items
{
    [super setItems:items];
    
    self.checkedIndex = self.checkedIndex;
    self.checkedItem = self.checkedItem;
    self.sourceItem = self.sourceItem;
}

- (void)setSourceItem:(XYSettingLabelItem *)sourceItem
{
    _sourceItem = sourceItem;
    
    for (XYSettingCheckItem *item in self.items) {
        item.checked = [item.title isEqualToString:sourceItem.text];
    }
}


@end
