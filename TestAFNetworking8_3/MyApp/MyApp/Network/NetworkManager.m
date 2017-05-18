//
//  NetworkManager.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "NetworkManager.h"
#import "SingletonScript.h"

@interface NetworkManager () {
    
}

@end

@implementation NetworkManager

SYNTHESIZE_SINGLETON_FOR_CLASS(NetworkManager);

@synthesize data;

-(void)fetchData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"network_config" ofType:@"plist"];
    self.data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}


@end
