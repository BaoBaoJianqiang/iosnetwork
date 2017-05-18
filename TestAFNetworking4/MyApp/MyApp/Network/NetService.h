//
//  NetService.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetService : NSObject

-(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(UIViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback;

@end
