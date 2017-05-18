//
//  AppDelegate.m
//  MyApp
//
//  Created by baojianqiang on 16/4/6.
//  Copyright © 2016年 baojianqiang. All rights reserved.
//

#import "AppDelegate.h"
#import "APageViewController.h"
#import "Navigator.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "NetworkManager.h"

#import "CacheManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    //读取所有网络请求配置
    [[NetworkManager getInstance] fetchData];
    
    [[CacheManager getInstance] start];
    
    
    //用NSObject的方法创建一个多线程
    //[self performSelectorInBackground:@selector(multiThread) withObject:nil];
    
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.rootViewController = [[APageViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    
    self.window.rootViewController = self.navController;
    
    //注册Navigator
    [Navigator sharedNavigator].nav = self.navController;

    [self.window makeKeyAndVisible];

    return YES;
}

-(void)multiThread {
    if (![NSThread isMainThread]) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:20.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

-(void)timerAction {
    if (![NSThread isMainThread]) {
        [[CacheManager getInstance] saveDataToFile];
    } 
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
