//
//  CacheManager.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+(CacheManager*)getInstance;

@property(nonatomic, strong)NSMutableDictionary* cacheData;

-(void)start;

-(void)saveDataToCache;

-(NSDictionary*)getDataFromCache: (NSString*)key;

-(void)setDataFromCache:(NSString *)key
              withValue:(NSDictionary*)dic
             expireTime:(NSDate*)expireTime;

@end
