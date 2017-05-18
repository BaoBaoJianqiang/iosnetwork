//
//  BaseViewController+Extension.m
//  MyApp
//
//  Created by jianqiang on 16/10/24.
//  Copyright © 2016年 baojianqiang. All rights reserved.
//

#import "BaseViewController+Extension.h"

#define LoadingViewTag 22123

@implementation BaseViewController (Extension)

-(void)showLoading {
    UIActivityIndicatorView* activityIndicatorView = [self.view viewWithTag: LoadingViewTag];
    if(activityIndicatorView == nil) {
        activityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        [activityIndicatorView setTag: LoadingViewTag];
        activityIndicatorView.center=self.view.center;
        [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityIndicatorView setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview: activityIndicatorView];
    }
    
    [activityIndicatorView startAnimating];

}

- (void)stopLoading{
    UIActivityIndicatorView* activityIndicatorView = [self.view viewWithTag: LoadingViewTag];
    if(activityIndicatorView!=nil) {
        [activityIndicatorView stopAnimating];
    }
}

@end
