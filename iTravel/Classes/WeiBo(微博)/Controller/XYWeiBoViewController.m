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
#import "AFNetworking.h"
#import "XYAccountTool.h"
#import "XYAccount.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "XYStatus.h"
#import "XYStatusFrame.h"
#import "XYUser.h"
#import "XYStatusCell.h"
#import "XYPhoto.h"


#define titleButtonTagUP -1
#define titleButtonTagDown 0

@interface XYWeiBoViewController()

//@property (nonatomic,weak) UIButton *popBtn;
@property (nonatomic, strong)NSMutableArray *statusFrames;

@end

@implementation XYWeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 设置导航栏
    [self setupNavBar];
    
    // 2. 加载微博数据
    [self setupStatusData];
}

- (void)setupStatusData
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XYAccountTool account].access_token;
    params[@"count"] = @20;
    
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@",responseObject);
//        // 1.字典转模型
//        NSArray *statusArr = responseObject[@"statuses"];
//        // 字典转模型并直接存入frame中
//        NSMutableArray *arrayM = [NSMutableArray array];
//        for (NSDictionary *dic in statusArr) {
//            XYStatus *status = [XYStatus objectWithKeyValues:dic];
//            
//            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
//            statusFrame.status = status;
//            
//            [arrayM addObject:statusFrame];
//        }
//        // 2.给自己的数组赋值
//        self.statusFrames = arrayM;
        
        // 1.将字典数组转为模型数组(里面放的就是XYStatus模型)
        NSArray *statusArray = [XYStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 2.创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XYStatus *status in statusArray) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        // 赋值
        self.statusFrames = statusFrameArray;
        
        
        // 3.加载完数据必须先进行一次数据刷新
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// 设置NavBar
- (void)setupNavBar
{
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
    
    // 4. 自己tableView 的一些简单设置
    self.tableView.backgroundColor = XYColor(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XYStatusTableBorder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // cell 分割线
}
// 标题按钮点击
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
// Nav左按钮点击
- (void)findFriend
{
    DLog(@"findFriendfindFriendfindFriend");
}
// Nav右按钮点击
- (void)pop
{
    DLog(@"poppoppoppoppop");
   
//    // 弹出的背景按钮
//    UIView *popView = [[UIView alloc] init];
//    UIButton *popSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    popView.frame = CGRectMake(100, 0, 200, 50);
//    self.popBtn = popSearchBtn;
//
//    if (1) {
//        [self.view addSubview:popView];
//        
//        // 弹出pop按钮
//        [popSearchBtn setImage:[UIImage imageWithName:@"navigationbar_pop"] forState:UIControlStateNormal];
//        [popSearchBtn setImage:[UIImage imageWithName:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
//        [popSearchBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
//        popSearchBtn.frame = CGRectMake(0, 5, 200, 40);
//        [popSearchBtn addTarget:self action:@selector(popBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [popView addSubview:self.popBtn];
//        
//
//    }else
//    {
//        
////        [popSearchBtn removeFromSuperview];
//        [self.popBtn removeFromSuperview];
//        [self.popBtn setFrame:CGRectMake(0, 0, 1, 1)];
//        [popView removeFromSuperview];
//        popSearchBtn = nil;
//        popView = nil;
//        [popSearchBtn delete:popSearchBtn];
//    }
}

- (void)popBtnClick:(UIButton *)popBtn
{
    DLog(@"---你好，点击了pop按钮！");
}


#pragma  --- mark TableViewDelegate && TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 默认为1
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // self.statusArray.count 存放的是statusFrame的个数
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 1.创建cell
//    static NSString *cellID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
//    
//    // 2.给cell设置数据
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/thumbnail/4364c6bejw1f2iqpbjsekj20c80c8mxo.jpg"] placeholderImage:nil];
//    cell.textLabel.text = @"hahah";
//    
//    // 3.返回cell
//    return cell;
    
    
    // 1.创建cell
    XYStatusCell *cell = [XYStatusCell cellWithTableView:tableView];
    
    // 2.给cell设置数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    // 3.返回cell
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    vc.hidesBottomBarWhenPushed = YES; // 这个不能每次都写，要拦截
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从statusFrame中取出cell的高度
    XYStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


@end
