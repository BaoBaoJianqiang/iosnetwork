//
//  NetService.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#define PREURL @"http://127.0.0.1:8888"

#import "NetService.h"
#import "NetworkManager.h"
#import "AFURLSessionManager.h"
#import "AFHTTPSessionManager.h"

#import "NewNetworkEntity.h"
#import "ObjectMappingLoader.h"

#import "SingletonScript.h"
#import "BaseViewController+Extension.h"

#import "CacheManager.h"
#import "MockService.h"

#import "Globals.h"

@interface NetService () {
    
}

@end

@implementation NetService

int loadingAPICount = 0;
int timeInterval = 0;

SYNTHESIZE_SINGLETON_FOR_CLASS(NetService);

+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController {
    [[self getInstance] invoke: key params:params target: viewController success:nil fail: nil force: NO retryTimes:-100];
}

+(void)invoke: (NSString*)key target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback {
    [[self getInstance] invoke: key params:nil target: viewController success:successCallback fail: failCallback force: NO retryTimes:-100];
}

+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback {
    [[self getInstance] invoke: key params:params target: viewController success:successCallback fail: failCallback force: NO retryTimes:-100];
}

+(void)invoke: (NSString*)key params:(NSMutableDictionary*)params target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback force:(BOOL)forceFlag {
    [[self getInstance] invoke: key params:params target: viewController success:successCallback fail: failCallback force:forceFlag retryTimes:-100];
}

-(void)invoke: (NSString*)key params:(NSDictionary*)params target:(BaseViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback force:(BOOL)forceFlag retryTimes: (int)retryTimes {
    
    //sigh, can't set __block in params
    __block int retryTimesInRecusive = retryTimes;
    
    id config = [[NetworkManager getInstance].data valueForKey: key];
    if(config) {
        NSString* netType = config[@"NetType"];
        NSString* url = [NSString stringWithFormat:@"%@/%@", PREURL, config[@"Url"]];
        NSString* expires = config[@"Expires"];
        int retryTimesInConfig = [config[@"retryTimes"] intValue];
        
        //第一次进来，如果有重试机制
        if(retryTimesInRecusive == -100 && retryTimesInConfig > 0){
            retryTimesInRecusive = retryTimesInConfig;
        }
        
        NSDictionary* mockData = [MockService getInstance].mockData;
        if(mockData) {
            id data = [mockData valueForKey:key];
            if(data) {
                [viewController performSelector: successCallback withObject: data];
                return;
            }
        }
            
        
        NSMutableString *strKeyAndValue = [NSMutableString new];
        
        NSMutableArray *keys = [NSMutableArray arrayWithArray:[params allKeys]];
        [keys sortUsingSelector:@selector(compare:)];
        
        for (NSString *key in keys) {
            [strKeyAndValue appendFormat:@"%@=%@", key, [params objectForKey:key]];
            [strKeyAndValue appendFormat:@"&"];
        }
        if ([keys count] > 0)
            [strKeyAndValue deleteCharactersInRange:NSMakeRange([strKeyAndValue length] - 1, 1)];
        
        NSString* cacheKey = url;
        if ([strKeyAndValue length] > 0) {
            cacheKey = [NSString stringWithFormat:@"%@?%@", url, strKeyAndValue];
        }

        //url就是我需要的缓存唯一key
        
        if([expires intValue] > 0 && !forceFlag) {
            //read data from Cache
            NSDictionary* dict = [[CacheManager getInstance] getDataFromCache: cacheKey];
            if(dict != nil) {
                [viewController performSelector: successCallback withObject: dict];
                return;
            }
        }
        
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        void (^successBlk)(NSURLSessionDataTask *task, id responseObject)  = ^(NSURLSessionDataTask *task, id responseObject){
            if(--loadingAPICount <= 0) {
                [viewController stopLoading];
            }

            //时间校准
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;

            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            
            NSDate *serverTime = [dateFormatter dateFromString: [allHeaders objectForKey:@"Date"]];
            NSDate *localTime = [NSDate new];
            [Globals getInstance].timeInterval = [serverTime timeIntervalSinceDate: localTime];
            
            
            if(!successCallback) {
                return;
            }
            
            id result = [ObjectMappingLoader loadObjectWithClassName: @"NewNetworkEntity" andData:responseObject];
            NewNetworkEntity* networkEntity = (NewNetworkEntity*)result;

            if([networkEntity.isError intValue] == 1) {
                [viewController performSelector: failCallback withObject: networkEntity.errorMessage];
            } else {
                NSDictionary* result = [responseObject valueForKey: @"result"];
                
                //set data from Cache
                if([expires intValue] > 0) {
                    NSDate* now = [NSDate date];    //这里时间从本地取值是不对的，需要时间校准
                    NSDate* newExpireTime = [NSDate dateWithTimeIntervalSinceNow: [expires intValue]];
                    [[CacheManager getInstance] setDataFromCache: cacheKey withValue: result expireTime: newExpireTime];
                }
                
                [viewController performSelector: successCallback withObject: result];
            }
        };
        
        void (^failBlk)(NSURLSessionDataTask *task, NSError *error) =  ^(NSURLSessionDataTask *task, NSError *error){
            if(--loadingAPICount <= 0) {
                [viewController stopLoading];
            }
            
            //retry
            if(retryTimesInConfig > 0 && retryTimesInRecusive > 0) {
                [self invoke: key params:params target: viewController success:successCallback fail: failCallback force:forceFlag retryTimes: --retryTimesInRecusive];
                return;
            }
            
            if(!failCallback) {
                return;
            }

            [viewController performSelector: failCallback withObject: @"未知错误"];
        };

        
        if([netType isEqualToString:@"get"]) {
            if(++loadingAPICount > 0) {
                [viewController showLoading];
            }
            
            [session GET: url parameters:params success:successBlk failure:failBlk];
        } else {
            if(++loadingAPICount > 0) {
                [viewController showLoading];
            }

            [session POST: url parameters:params success:successBlk failure:failBlk];
        }
    }
}

@end
