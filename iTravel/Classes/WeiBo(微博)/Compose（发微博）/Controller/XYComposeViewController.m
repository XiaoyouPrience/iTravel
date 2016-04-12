//
//  XYComposeViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/4/11.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "XYComposeViewController.h"
#import "XYTextView.h"
#import "AFNetworking.h"
#import "XYAccount.h"
#import "XYAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface XYComposeViewController()
@property (nonatomic,weak) XYTextView *textView;

@end

@implementation XYComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏主题
    [self setupNavTheme];
    
    // 设置textView
    [self setupTextView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

/**
 *  设置textView
 */
- (void)setupTextView
{
    // 1.添加textView
    XYTextView *textView = [[XYTextView alloc] init];
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholderColor = [UIColor redColor];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听文字录入
    [kNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
}

/**
 *  监听文字录入
 */
- (void)textDidChange
{
    DLog(@"%@",self.textView.text);
}

/**
 *  移除通知观察者
 */
- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}


/**
 *  设置导航栏主题
 */
- (void)setupNavTheme
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 因为导航栏是自己的，并且已经修改过样式了，所以必须重新写一些东西，而不是直接赋值
    // self.navigationItem.leftBarButtonItem.title = @"取消"; ---> 是错误的
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendNewWeibo)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.title = @"发微博";

}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendNewWeibo
{
    if ([self.textView.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"未输入要发送的内容哦！"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }else
    {
        // 1.创建管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // 2.封装请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [XYAccountTool account].access_token;
        params[@"status"] = self.textView.text;
        
        // 3.发送请求
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 发送成功
            [MBProgressHUD showSuccess:@"发送成功"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 发送失败
            [MBProgressHUD showError:@"发送失败"];
        }];
        
        
        // 4.关闭控制器
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
