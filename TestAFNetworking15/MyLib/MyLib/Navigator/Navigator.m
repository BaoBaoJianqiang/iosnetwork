//
//  Navigator.m
//
//  Created by Jianqiang on 13-11-15.
//  Copyright (c) 2013年. All rights reserved.
//

#import "Navigator.h"
#import "BaseViewController.h"
#import "NetService.h"

@implementation Navigator

@synthesize nav = _nav;

SYNTHESIZE_SINGLETON_FOR_CLASS(Navigator);

+ (void)navigateTo:(NSString *)viewController {
    [[self sharedNavigator] navigateTo:viewController withData:nil];
}

+ (void)navigateTo:(NSString *)viewController withData:(NSMutableDictionary *)param {
    [[self sharedNavigator] navigateTo:viewController withData:param];
}

- (void)navigateTo:(NSString *)viewController withData:(NSMutableDictionary*)param {
    
    //取消所有网络请求
    [[NetService getInstance] cancelAllRequest];

    BaseViewController * classObject = (BaseViewController *)[[NSClassFromString(viewController) alloc] init];
    classObject.param = param;
    
    [_nav pushViewController:classObject animated:YES];
}

@end
