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
#import "XYTool.h"
#import "XYAccountTool.h"
#import "MBProgressHUD+MJ.h"

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

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载，请稍后..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提示
    [MBProgressHUD hideHUD];
}


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
    // 1.封装请求参数
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"client_id"] = @"2681167680";
    parame[@"client_secret"] = @"5072b1af9da41b457202eb8b7ebfa30f";
    parame[@"grant_type"] = @"authorization_code";
    parame[@"code"] = code;
    parame[@"redirect_uri"] = @"http://www.baidu.com";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏提示
        [MBProgressHUD hideHUD];
        
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
        // 2.字典转模型
        XYAccount *account = [XYAccount modelWithDict:responseObject];
        
        // 存储账号对象
        [XYAccountTool saveAccount:account];
        // 3.选择控制器新特性\去首页
        [XYTool chooseRootController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);
        // 隐藏提示
        [MBProgressHUD hideHUD];
    }];
}


@end
