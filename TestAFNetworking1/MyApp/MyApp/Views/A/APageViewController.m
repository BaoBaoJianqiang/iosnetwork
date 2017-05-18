//
//  APageViewController.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "APageViewController.h"
#import "Navigator.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

@interface APageViewController () {
    UIButton* gotoBButton;
    UIButton* gotoCButton;
    UIButton* network101Button;
}

@end

@implementation APageViewController

- (void)initVariables {
    
}

- (void)initViews {
    //1.从xib中获取View
    NSArray* list = [[NSBundle mainBundle] loadNibNamed: @"APageView" owner: self options: nil];
    self.view = list.lastObject;
    
    gotoBButton = (UIButton*)[self.view viewWithTag: 500];
    [gotoBButton addTarget: self action: @selector(gotoB) forControlEvents:UIControlEventTouchUpInside];

    gotoCButton = (UIButton*)[self.view viewWithTag: 1000];
    [gotoCButton addTarget: self action: @selector(gotoC) forControlEvents:UIControlEventTouchUpInside];
    
    network101Button = (UIButton*)[self.view viewWithTag: 101];
    [network101Button addTarget: self action: @selector(visitNetwork) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)loadData {
    //调用MobileAPI，发起网络请求，获取页面初始化数据
}

- (void) gotoB {
    NSString* url = @"BPageViewController";
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setValue: @"Jianqiang" forKey: @"UserName"];
    
    [Navigator navigateTo: url withData: data];
}

- (void) gotoC {
    NSString* url = @"CPageViewController";
    [Navigator navigateTo: url];
}

- (void) visitNetwork {
    NSDictionary *params = @{@"cinemaId":@"1"};
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session GET:@"http://127.0.0.1:8888/cinema/getcinemadetail" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary* dic = (NSDictionary*)responseObject;
        
        NSString* str = [responseObject objectForKey:@"result"];
        
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
}

@end
