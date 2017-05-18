//
//  NewNetworkEntity.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "NewNetworkEntity.h"
#import "ObjectMapping.h"

@interface NewNetworkEntity () {
    
}

@end

@implementation NewNetworkEntity

@synthesize isError;
@synthesize errorType;
@synthesize errorMessage;
@synthesize result;

- (ObjectMapping *)objectMapping {
    ObjectMapping *mapping = [ObjectMapping mappingForClass:[NewNetworkEntity class]];
    [mapping converEntityFromJsonToEntity:@"isError" to:@"isError" withClass: @"NSNumber"];
    [mapping converEntityFromJsonToEntity:@"errorType" to:@"errorType" withClass: @"NSNumber"];
    [mapping converEntityFromJsonToEntity:@"errorMessage" to:@"errorMessage" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"result" to:@"result" withClass: @"NSString"];
    return mapping;
}

@end



