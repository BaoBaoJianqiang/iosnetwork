//
//  BaseViewController+Extension.m
//  MyApp
//
//  Created by jianqiang on 16/10/24.
//  Copyright © 2016年 baojianqiang. All rights reserved.
//

#import "BaseViewController+Extension.h"
#import "UIView+Sizes.h"

#define LoadingViewTag 22123

@implementation BaseViewController (Extension)

-(void)showLoading {
    
    UIView *loadView = [self.view viewWithTag:LoadingViewTag];
    if (nil == loadView) {
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGRect viewFrame = self.view.frame;
        CGRect loadViewRect = CGRectMake(0, 0, bounds.size.width, viewFrame.size.height);
        loadView = [[UIView alloc] initWithFrame:loadViewRect];
        loadView.tag = LoadingViewTag;
        loadView.alpha = 1.0;
        //loadView.backgroundColor = [UIColor whiteColor];
        loadView.backgroundColor = [UIColor clearColor];
    
    
        // background image
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        CGPoint center = window.center;
        center = [self.view convertPoint:center fromView:window];
    
        CGRect rect = CGRectMake(center.x - 133, center.y - 25, 266, 50);
        UIImage *bgImage = [UIImage imageNamed: @"ele_pop_bg.png"];
        bgImage = [bgImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bgImage];
        bgView.frame = rect;
        [loadView addSubview:bgView];
    
        // text label
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, center.y - 8, 0, 30)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.text = @"加载中";
        [textLabel sizeToFit];
        textLabel.left = center.x - textLabel.width / 2 + 10;
        [loadView addSubview:textLabel];
    
    
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        rect = CGRectMake(textLabel.left - 35, center.y - 15, 30, 30);
        activityView.frame = rect;
        [activityView startAnimating];
        [loadView addSubview:activityView];
    
        [self.view addSubview:loadView];
    }
}

- (void)stopLoading{
    UIView *loadView = [self.view viewWithTag: LoadingViewTag];
    if(loadView!=nil) {
        [loadView removeFromSuperview];
    }
}

@end
