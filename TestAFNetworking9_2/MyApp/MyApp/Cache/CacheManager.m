//
//  CacheManager.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "CacheManager.h"
#import "SingletonScript.h"

#define FileName @"cache"

@interface CacheManager () {
    BOOL isLocked;
    NSString* cacheFilePath;    
}

@end

@implementation CacheManager

SYNTHESIZE_SINGLETON_FOR_CLASS(CacheManager);

@synthesize cacheData;

-(void)start {
    if(self.cacheData == nil) {
        cacheData = [[NSMutableDictionary alloc] init];
        isLocked = NO;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,  NSUserDomainMask, YES);
        NSString *cachesDirectoryPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Caches"];
        
        cacheFilePath = [cachesDirectoryPath stringByAppendingPathComponent: FileName];
    }
    
    //read from local cache
    [self readDataFromFile];
}

-(void)saveDataToFile {
    //delete expired data
    NSMutableArray* array = [NSMutableArray new];
    
    for(NSString* url in self.cacheData.allKeys) {
        NSDictionary* cacheItem = [self.cacheData objectForKey: url];
        NSDate* expireTime = [cacheItem objectForKey:@"expireTime"];
        if([[NSDate date] timeIntervalSinceDate:expireTime] >= 0.0) {
            [array addObject: url];
        }
    }

    isLocked = YES;
    
    
    
    
    if(array.count > 0) {
        [self.cacheData removeObjectsForKeys: array];
    }
    
    BOOL result = [self.cacheData writeToFile: cacheFilePath atomically: NO];
    
    isLocked = NO;
}

-(void)readDataFromFile {
    NSFileManager *fmanager=[NSFileManager defaultManager];
    if (![fmanager fileExistsAtPath:cacheFilePath]) {
        return;
    }
    
    NSDictionary*  dic = [NSDictionary dictionaryWithContentsOfFile: cacheFilePath];
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    //delete expired data
    NSMutableArray* array = [NSMutableArray new];
    
    for(NSString* url in newdic.allKeys) {
        NSDictionary* cacheItem = [newdic objectForKey: url];
        NSDate* expireTime = [cacheItem objectForKey:@"expireTime"];
        if([[NSDate date] timeIntervalSinceDate:expireTime] >= 0.0) {
            [array addObject: url];
        }
    }

    if(array.count > 0) {
        [newdic removeObjectsForKeys: array];
    }

    
    isLocked = YES;
    
    self.cacheData = newdic;
    
    isLocked = NO;
}

-(NSDictionary*)getDataFromCache: (NSString*)key {
    if(isLocked)
        return nil;
    
    NSDictionary *cacheItem = [self.cacheData objectForKey: key];
    if (nil == cacheItem)
        return nil;
    
    NSDate* expireTime = [cacheItem objectForKey:@"expireTime"];
    
    if([[NSDate date] timeIntervalSinceDate:expireTime] >= 0.0) {
        return nil;
    }
    
    return [cacheItem objectForKey:@"data"];
}

-(void)setDataFromCache:(NSString *)key withValue:(NSDictionary*)dic expireTime:(NSDate*)expireTime {
    if(isLocked)
        return;

    NSDictionary* cacheItem = @{@"expireTime": expireTime, @"data": dic};
    [self.cacheData setObject: cacheItem forKey: key];
}

@end
