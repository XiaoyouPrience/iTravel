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
#import "XYComposeToolbar.h"

@interface XYComposeViewController()<UITextViewDelegate,XYComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) XYTextView *textView;
@property (nonatomic,weak) XYComposeToolbar *composeToolbar;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation XYComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏主题
    [self setupNavTheme];
    
    // 设置textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加imageView
    [self setupImageView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}


/**
 *  添加imageView
 */
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(5, 80, 60, 60);
    [self.textView addSubview:imageView];
    self.imageView = imageView;
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    XYComposeToolbar *toolbar = [[XYComposeToolbar alloc] init];
    toolbar.backgroundColor = [UIColor redColor];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.composeToolbar = toolbar;
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(XYComposeToolbar *)toolbar didClickedButton:(XYComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case XYComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case XYComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    NSLog(@"%@", info);
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
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听文字录入
    [kNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    
    // 3.监听键盘的通知
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

/**
 *  监听文字录入
 */
- (void)textDidChange
{
    DLog(@"%@",self.textView.text);
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.composeToolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.composeToolbar.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  移除通知观察者
 */
- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}


#pragma mark - scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
/**
 *  取消发送微博
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送微博
 */
- (void)sendNewWeibo
{
    
    // 0.判断输入内容是否为空
    if ([self.textView.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"未输入要发送的内容哦！"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        
        return;
    }
    
    
    // 1.发微博 -- 判断类型
    if (self.imageView.image) {// 发送有图片的微博
        [self sendWithImage];
    }else
    {   // 发送没有图片的微博
        [self sendWithoutImage];
    }
    
    // 2.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
/**
 *  发送有图片的微博
 */
- (void)sendWithImage
{
    
    // 1.创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XYAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 在发送请求之前调用这个block
        // 必须要在这里说明要上传那些文件
        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 0.5);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"我的上传" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 发送成功
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 发送失败
        [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 *  发送没有图片的微博
 */
- (void)sendWithoutImage
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
}

@end
