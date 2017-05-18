//
//  MockService.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "MockService.h"
#import "SingletonScript.h"

@interface MockService () {
    
}

@end

@implementation MockService

SYNTHESIZE_SINGLETON_FOR_CLASS(MockService);

@synthesize mockData;

-(void)startEngine {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"mock_data" ofType:@"plist"];
    self.mockData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}


@end
