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
//#import "AFNetworking.h"
#import "XYAccountTool.h"
#import "XYAccount.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "XYStatus.h"
#import "XYStatusFrame.h"
#import "XYUser.h"
#import "XYStatusCell.h"
#import "XYPhoto.h"
#import "XYTitleButton.h"
#import "MJRefresh.h"
#import "XYHttpTool.h"
#import "XYStatusTool.h"
#import "XYHomeStatusesParam.h"


#define titleButtonTagUP -1
#define titleButtonTagDown 0

@interface XYWeiBoViewController()

//@property (nonatomic,weak) UIButton *popBtn;
@property (nonatomic, strong)NSMutableArray *statusFrames;
@property (nonatomic,weak) XYTitleButton *titleButton;

@end

@implementation XYWeiBoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建页面
    [self buildUI];
    
    
    // 2. 加载微博数据
    [self setupStatusData];
}

/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XYAccountTool account].access_token;
    params[@"count"] = @20;

    [XYHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id json) {
        DLog(@"%@",json);
        
        // 1.将字典数组转为模型数组(里面放的就是XYStatus模型)
        NSArray *statusArray = [XYStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
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
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)buildUI
{
    // 1. 设置导航栏
    [self setupNavBar];
    
    // 2.添加刷新控件
    [self setupRefreshView];
    
    // 3.获取用户信息
    [self setupUserData];
}

/**.获取用户信息*/
- (void)setupUserData
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XYAccountTool account].access_token;
    params[@"uid"] = @([XYAccountTool account].uid);
    
    [XYHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        // 1.字典转模型
        XYUser *user = [XYUser objectWithKeyValues:json];
        
        // 2.设置标题文字
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 3.保存用户名称
        XYAccount *account = [XYAccountTool account];
        account.name = user.name;
        [XYAccountTool saveAccount:account];

    } failure:^(NSError *error) {
        
    }];
}
/**
 *  添加刷新控件
 */
- (void)setupRefreshView
{
//    // 1.添加系统刷新控件
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(refreshControlStateChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshControl];
//    
//    // 2.自动进入刷新状态（不会触动监听方法）
//    [refreshControl beginRefreshing];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [refreshControl endRefreshing];
//    });
//    
//
//    // 3.加载数据
//    [self refreshControlStateChange:refreshControl];
    
    
    // 上拉刷新控件
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    [self.tableView.mj_header beginRefreshing];
    // 进来直接自动进入刷新状态(这个是只有提示，但是没有进入刷新效果上)
    [self refreshControlStateChange:tableView.mj_header];
    
    
    // 下拉刷新
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 加载数据
        [self refreshControlStateChange:tableView.mj_header];
        
        [tableView.mj_header endRefreshing];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData:tableView.mj_footer];
    }];

}

/**
 *  上拉加载更多的微博数据
 */
- (void)loadMoreData:(MJRefreshFooter *)footer
{
    
    // 开始刷新数据，请求最新数据（数据ID必须大于之前的那些）
    
    // 1.封装请求参数
    XYHomeStatusesParam *param = [[XYHomeStatusesParam alloc] init];
    param.access_token = [XYAccountTool account].access_token;
    param.count = 20;
    
    // 取出目前最新的微博ID来
    if(self.statusFrames.count)
    {
        XYStatusFrame *statusF = self.statusFrames.lastObject;
        XYStatus *status = statusF.status;
        long long max_id = status.idstr.longLongValue - 1; // 是最后一条数据之前的那一条微博数据
        param.max_id = max_id;
    }
    
    // 2.发送请求
    [XYStatusTool homeStatusesWithParam:param success:^(id json) {
        // 1.将字典数组转为模型数组(里面放的就是XYStatus模型 --- 但是这次全是新的微博数据)
        NSArray *statusArray = [XYStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 2.创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XYStatus *status in statusArray) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 赋值
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        
        // 3.加载完数据必须先进行一次数据刷新
        [self.tableView reloadData];
        
        // 4.刷新空间停止刷新
        [footer endRefreshing];


    } failure:^(NSError *error) {
        
        [footer endRefreshing];

    }];
    
}

/**
 *  下拉加载更新的数据 --- 手动刷新监听的方法
 */
- (void)refreshControlStateChange:(MJRefreshHeader *)header
{
    DLog(@"==refreshControlStateChange==");
    
    // 开始刷新数据，请求最新数据（数据ID必须大于之前的那些）
    
    // 1.封装请求参数
    XYHomeStatusesParam *param = [[XYHomeStatusesParam alloc] init];
    param.access_token = [XYAccountTool account].access_token;
    param.count = 20;
    
    // 取出目前最新的微博ID来
    if(self.statusFrames.count)
    {
        XYStatusFrame *statusF = self.statusFrames[0];
        XYStatus *status = statusF.status;
        NSString *since_id = status.idstr;
        param.since_id = [since_id longLongValue];
    }
    
    // 2.发送请求
    [XYStatusTool homeStatusesWithParam:param success:^(id json) {
        // 1.将字典数组转为模型数组(里面放的就是XYStatus模型 --- 但是这次全是新的微博数据)
        NSArray *statusArray = [XYStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 2.创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XYStatus *status in statusArray) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 把新数据放到旧数据之前展示
        // self.statusFrames -- 旧数据
        // statusFrameArray -- 新数据
        NSMutableArray *tempArr = [NSMutableArray array];
        [tempArr addObjectsFromArray:statusFrameArray];
        [tempArr addObjectsFromArray:self.statusFrames];
        
        // 赋值
        self.statusFrames = tempArr;
        
        
        // 3.加载完数据必须先进行一次数据刷新
        [self.tableView reloadData];
        
        // 4.刷新空间停止刷新
        [header endRefreshing];
        
        // 5. 给用户一些友好的提示
        [self showNewStatusCount:statusFrameArray.count];
    } failure:^(NSError *error) {
        
        [header endRefreshing];
        
    }];
    
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(unsigned long)count
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // below : 下面  btn会显示在self.navigationController.navigationBar的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resiedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%ld条新的微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    // 3.设置按钮的初始frame
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 2;
    CGFloat btnW = self.view.frame.size.width - 2 * btnX;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    // 4.通过动画移动按钮(按钮向下移动 btnH + 1)
    [UIView animateWithDuration:0.7 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
        
    } completion:^(BOOL finished) { // 向下移动的动画执行完毕后
        
        // 建议:尽量使用animateWithDuration, 不要使用animateKeyframesWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 将btn从内存中移除
            [btn removeFromSuperview];
        }];
        
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
    if ([XYAccountTool account].name) {
        [button setTitle:[XYAccountTool account].name forState:UIControlStateNormal];
    }else
    {
        [button setTitle:@"我的微博" forState:UIControlStateNormal];
    }
    [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
    self.titleButton = button;
    
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
