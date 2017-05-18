//
//  NetworkEntity.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "NetworkEntity.h"

#import <YYModel/YYModel.h>

@interface NetworkEntity () {
    
}

@end

@implementation NetworkEntity

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"isError" : @"isError",
             @"errorType" : @"errorType",
             @"errorMessage" : @"errorMessage",
             @"result" : @"NSObject"};
}

@end
