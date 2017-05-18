//
//  NetService.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NetService : NSObject

+(NetService*)getInstance;

-(void)startEngine;

//不需要回调，
//successCallback和failCallback，同生同灭
+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController;

//不需要参数
+(void)invoke: (NSString*)key target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback;


+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback;

//最完整的API
+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback force:(BOOL)forceFlag;

//取消所有请求
- (void)cancelAllRequest;

@end
