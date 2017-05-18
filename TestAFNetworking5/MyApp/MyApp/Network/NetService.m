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

@interface NetService () {
    
}

@end

@implementation NetService

-(void)invoke: (NSString*)key params:(NSDictionary*)params target:(UIViewController*)viewController success:(SEL)successCallback fail:(SEL)failCallback {
    id config = [[NetworkManager getInstance].data valueForKey: key];
    if(config) {
        NSString* netType = config[@"NetType"];
        NSString* url = [NSString stringWithFormat:@"%@/%@", PREURL, config[@"Url"]];
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        void (^successBlk)(NSURLSessionDataTask *task, id responseObject)  = ^(NSURLSessionDataTask *task, id responseObject) {
            
            id result = [ObjectMappingLoader loadObjectWithClassName: @"NewNetworkEntity" andData:responseObject];
            NewNetworkEntity* networkEntity = (NewNetworkEntity*)result;

            
            
            
            if([networkEntity.isError intValue] == 1) {
                [viewController performSelector: failCallback withObject: networkEntity.errorMessage];
            } else {
                NSDictionary* result = [responseObject valueForKey: @"result"];
                [viewController performSelector: successCallback withObject: result];
            }
        };
        
        void (^failBlk)(NSURLSessionDataTask *task, NSError *error) =  ^(NSURLSessionDataTask *task, NSError *error){
            [viewController performSelector: failCallback withObject: @"未知错误"];
        };

        
        if([netType isEqualToString:@"get"]) {
            [session GET: url parameters:params success:successBlk failure:failBlk];
        } else {
            [session POST: url parameters:params success:successBlk failure:failBlk];
        }
        
        
    
    
    
    }
}

@end
