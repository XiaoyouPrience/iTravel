//
//  XYOAuthViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/31.
//  Copyright © 2016年 XY. All rights reserved.
//  授权页面 -- 加载网页

#import "XYOAuthViewController.h"
#import "AFNetworking.h"
#import "XYAccount.h"
#import "XYTabBarViewController.h"
#import "XYNewFeatureViewController.h"


@interface XYOAuthViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;

@end

@implementation XYOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    self.webView = webView;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    // 加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2681167680&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


#pragma mark - webView Delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 0.取得request.url
    // http://www.baidu.com/?code=2d872ac2538a60692f2a1f5123e4dd2f
    DLog(@"%@",request.URL);
    
    // 1.找出 code= 后面的请求标记
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    
    // 2.找到请求标记
    if (range.location != NSNotFound) {
        
        // 2.1取得 code= 后面的请求标记
        unsigned long codeLoc = range.location + range.length;
        NSString *code = [url substringFromIndex:codeLoc];
        
        DLog(@"%@",code);
        
        // 2.2 发送请求获取accessToken
        
        [self requestForAccessToken:code];
        
    }
    
    return YES;
}

- (void)requestForAccessToken:(NSString *)code
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 封装请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"client_id"] = @"2681167680";
    parame[@"client_secret"] = @"5072b1af9da41b457202eb8b7ebfa30f";
    parame[@"grant_type"] = @"authorization_code";
    parame[@"code"] = code;
    parame[@"redirect_uri"] = @"http://www.baidu.com";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        /**
         *  {
         "access_token" = "2.00H8BeCGAMu8vC592b5c80ea5OnQWC";
         "expires_in" = 157679999;
         "remind_in" = 157679999;
         uid = 5535888309;
         }
         */
        DLog(@"%@--%@",[responseObject class],responseObject);
        
        // 存储accessToken信息
        // 字典转模型
        XYAccount *account = [XYAccount modelWithDict:responseObject];
        
        // 存储对象
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
        [NSKeyedArchiver archiveRootObject:account toFile:file];
        
        // 6.新特性\去首页
        NSString *key = @"CFBundleVersion";
        
        // 取出沙盒中存储的上次使用软件的版本号
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *lastVersion = [defaults stringForKey:key];
        
        // 获得当前软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        
        if ([currentVersion isEqualToString:lastVersion]) {
            // 显示状态栏
            [UIApplication sharedApplication].statusBarHidden = NO;
            self.view.window.rootViewController = [[XYTabBarViewController alloc] init];
        } else { // 新版本
            self.view.window.rootViewController = [[XYNewFeatureViewController alloc] init];
            // 存储新版本
            [defaults setObject:currentVersion forKey:key];
            [defaults synchronize];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);
    }];
}


@end
