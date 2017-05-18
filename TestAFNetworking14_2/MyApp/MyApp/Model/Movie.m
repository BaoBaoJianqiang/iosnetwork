//
//  Movie.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "Movie.h"

#import "YYModel.h"

@interface Movie () {
    
}

@end

@implementation Movie

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"movieId" : @"movieId",
             @"movieName" : @"movieName"};
}

@end
