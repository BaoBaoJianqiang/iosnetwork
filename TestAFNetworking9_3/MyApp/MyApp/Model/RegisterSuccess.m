//
//  RegisterSuccess.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "RegisterSuccess.h"

#import <YYModel/YYModel.h>

@interface RegisterSuccess () {
    
}

@end

@implementation RegisterSuccess

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"isError" : @"isError",
             @"errorMessage" : @"errorMessage"};
}

@end
