//
//  Globals.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "Globals.h"
#import "SingletonScript.h"

@interface Globals () {
    
}

@end

@implementation Globals

SYNTHESIZE_SINGLETON_FOR_CLASS(Globals);

@synthesize timeInterval;

@end
