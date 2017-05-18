//
//  Cinema.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "Cinema.h"

#import <YYModel/YYModel.h>

@interface Cinema () {
    
}

@end

@implementation Cinema

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"cinemaId" : @"cinemaId",
             @"cinemaName" : @"cinemaName"};
}

@end
