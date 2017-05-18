//
//  MovieList.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "MovieList.h"
#import "Movie.h"

#import <YYModel/YYModel.h>

@interface MovieList () {
    
}

@end

@implementation MovieList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"movieList" : [Movie class]};
}

@end
