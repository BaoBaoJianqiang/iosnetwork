//
//  NetworkManager.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+(NetworkManager*)getInstance;

@property(nonatomic, strong)NSDictionary* data;


-(void)fetchData;

@end
