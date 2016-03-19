//
//  XYNavigationViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/13.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYWeiBoViewController.h"
#import "UIBarButtonItem+XY.h"
#import "XYTitleButton.h"

#define titleButtonTagUP -1
#define titleButtonTagDown 0

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
    
    // 3. 中间按钮
    XYTitleButton *button = [[XYTitleButton alloc] init];
    button.frame = CGRectMake(0, 0, 120, 40);
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    
}

- (void)titleButtonClick:(XYTitleButton *)titleButton
{
    //点击切换image ---
    if (titleButton.tag == titleButtonTagDown) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = titleButtonTagUP;
    }else if(titleButton.tag == titleButtonTagUP)
    {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = titleButtonTagDown;
    }
//    或者通过iamgeNamed方法有缓存也可以，判断是不是那个图片(这个是基于图片有缓存，所以可以用这个！)
//    if (titleButton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_up"])
//    {
//        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    }else if (titleButton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_down"])
//    {
//        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
//    }
    
    DLog(@" ------titleButtonClick------ ");
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
