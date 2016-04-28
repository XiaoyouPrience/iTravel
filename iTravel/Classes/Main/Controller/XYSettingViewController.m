//
//  XYSettingViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYSettingViewController.h"
#import "XYSettingGroup.h"
#import "XYSettingArrowItem.h"
#import "XYSettingCheckItem.h"
#import "XYSettingCheckGroup.h"
#import "XYSettingCell.h"

@implementation XYSettingViewController


- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (XYSettingGroup *)addGroup
{
    XYSettingGroup *group = [XYSettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidAppear:(BOOL)animated {}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = nil;
    self.view.backgroundColor = kGlobalBg;
    
    self.tableView.sectionHeaderHeight = 0; // 每一组的头部高度
    self.tableView.sectionFooterHeight = XYSettingCellMargin; // 每一组的尾部高度
    
    // 底部控件
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, 0, 1);
    self.tableView.tableFooterView = footer;
    
    if (iOS7) {
        self.tableView.contentInset = UIEdgeInsetsMake(XYSettingCellMargin - 33, 0, 0, 0);
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(XYSettingCellMargin, 0, 0, 0);
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XYSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSettingCell *cell = [XYSettingCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    XYSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

#pragma mark - 代理
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    XYSettingGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    XYSettingGroup *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出模型
    XYSettingGroup *group = self.groups[indexPath.section];
    XYSettingItem *item = group.items[indexPath.row];
    
    // 2.操作
    if (item.option) {
        item.option();
    }
    
    // 3.跳转
    if ([item isKindOfClass:[XYSettingArrowItem class]]) {
        XYSettingArrowItem *arrowItem = (XYSettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            
            if (arrowItem.readyForDestVc) { // 控制器的准备工作
                arrowItem.readyForDestVc(arrowItem, destVc);
            }
            
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
    
    // 4.check 打钩
    if ([item isKindOfClass:[XYSettingCheckItem class]]) {
        XYSettingCheckGroup *checkGroup = (XYSettingCheckGroup *)group;
        checkGroup.checkedIndex = indexPath.row;
        
        // 刷新
        [tableView reloadData];
    }
}


@end
