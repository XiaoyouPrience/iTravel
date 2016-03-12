//
//  ViewController.m
//  iTravel
//
//  Created by XiaoYou on 16/3/11.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *array = @[@1,@2,@3,@4,@5];
    
    
    // 遍历数组
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@" obj == %@ . idx == %ld . stop == %@",obj,idx,stop?@"yes":@"no");
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
