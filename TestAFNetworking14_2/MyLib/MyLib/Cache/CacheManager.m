//
//  CacheManager.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "CacheManager.h"
#import "SingletonScript.h"

#import "CacheEntitiy.h"

@interface CacheManager () {
    
}

@end

@implementation CacheManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CacheManager);

@synthesize cacheData;

-(void)start {
    if(self.cacheData == nil) {
        cacheData = [[NSMutableDictionary alloc] init];
    }
    
    //read from local cache
}

-(void)saveDataToCache {
    
}

-(NSDictionary*)getDataFromCache: (NSString*)key {
    CacheEntitiy *item = [self.cacheData objectForKey: key];
    if (nil == item)
        return nil;
    
    if([[NSDate date] timeIntervalSinceDate:item.expireTime] >= 0.0) {
        return nil;
    }
    
    return item.data;
}

-(void)setDataFromCache:(NSString *)key withValue:(NSDictionary*)dic expireTime:(NSDate*)expireTime {
    CacheEntitiy *item = [CacheEntitiy new];
    item.expireTime = expireTime;
    item.data = dic;
    [self.cacheData setObject: item forKey: key];
}

// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

// 将JSON串转化为字典或者数组
- (id)toDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

@end
