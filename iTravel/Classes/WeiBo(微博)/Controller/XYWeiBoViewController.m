//
//  XYNavigationViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYWeiBoViewController.h"
#import "UIBarButtonItem+XY.h"
#import "XYSearchBar.h"

@interface XYWeiBoViewController()

@end

@implementation XYWeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 导航栏左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highlightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 2. 导航栏右边按钮
    // 这个是整个项目中可能都会用到的东西--所以应该封装到分类中去
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highlightIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    // 3.ti
    XYSearchBar *searchBar = [XYSearchBar searchBar];
    [self.view addSubview:searchBar];
    
}

- (void)findFriend
{
    DLog(@"findFriendfindFriendfindFriend");
}

- (void)pop
{
    DLog(@"poppoppoppoppop");
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
