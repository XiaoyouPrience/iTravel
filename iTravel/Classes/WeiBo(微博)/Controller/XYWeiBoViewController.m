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

@property(nonatomic, assign) BOOL itemClicked;

@property (nonatomic,weak) UIButton *popBtn;

@end

@implementation XYWeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 导航栏左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highlightIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 2. 导航栏右边按钮
    // 这个是整个项目中可能都会用到的东西--所以应该封装到分类中去
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_more" highlightIcon:@"navigationbar_more_highlighted" target:self action:@selector(pop)];
    
    // 3. 中间按钮
    XYTitleButton *button = [[XYTitleButton alloc] init];
    button.frame = CGRectMake(0, 0, 120, 40);
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    
}

- (void)titleButtonClick:(XYTitleButton *)titleButton
{
    DLog(@" ------titleButtonClick------ ");
    
    //点击切换image ---
    if (titleButton.tag == titleButtonTagDown) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = titleButtonTagUP;
        
        // 出现一个选择框
        
    }else if(titleButton.tag == titleButtonTagUP)
    {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = titleButtonTagDown;
    }


}
- (void)findFriend
{
    DLog(@"findFriendfindFriendfindFriend");
}

- (void)pop
{
    DLog(@"poppoppoppoppop");
   
    // 弹出的背景按钮
    UIView *popView = [[UIView alloc] init];
    UIButton *popSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popView.frame = CGRectMake(100, 0, 200, 50);
    self.popBtn = popSearchBtn;

    if (self.itemClicked == NO) {
        
        // 修改itemClick标记
        _itemClicked = !_itemClicked;
        
        [self.view addSubview:popView];
        
        // 弹出pop按钮
        [popSearchBtn setImage:[UIImage imageWithName:@"navigationbar_pop"] forState:UIControlStateNormal];
        [popSearchBtn setImage:[UIImage imageWithName:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
        [popSearchBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
        popSearchBtn.frame = CGRectMake(0, 5, 200, 40);
        [popSearchBtn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [popView addSubview:self.popBtn];
        

    }else
    {
        // 修改itemClick标记
        _itemClicked = !_itemClicked;
        
//        [popSearchBtn removeFromSuperview];
        [self.popBtn removeFromSuperview];
        [self.popBtn setFrame:CGRectMake(0, 0, 1, 1)];
        [popView removeFromSuperview];
        popSearchBtn = nil;
        popView = nil;
        [popSearchBtn delete:popSearchBtn];
    }
}

- (void)popBtnClick:(UIButton *)popBtn
{
    DLog(@"---你好，点击了pop按钮！");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    // 取消导航栏上的item的选中状态
    if (_itemClicked) {
        _itemClicked = !_itemClicked;
    }
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
