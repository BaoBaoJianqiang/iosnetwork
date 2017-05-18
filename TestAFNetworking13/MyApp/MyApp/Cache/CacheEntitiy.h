//
//  CacheEntitiy.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheEntitiy : NSObject

@property(nonatomic, strong) NSDate* expireTime;
@property(nonatomic, strong) NSDictionary* data;

@end
