//
//  XYNavigationViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYWeiBoViewController.h"

@interface XYWeiBoViewController()

@end

@implementation XYWeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"dianwo" style:UIBarButtonItemStyleBordered target:self action:@selector(itemClicked)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}
- (void)itemClicked
{
    DLog(@"点击了我");
}

#pragma  --- mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 默认为1
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    // 2.给cell设置数据
    cell.textLabel.text = @"hahah";
    
    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.hidesBottomBarWhenPushed = YES; // 这个不能每次都写，要拦截
    [self.navigationController pushViewController:vc animated:YES];
}


@end
