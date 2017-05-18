//
//  NetworkEntity.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkEntity : NSObject

@property NSString *isError;
@property NSString *errorType;
@property NSString *errorMessage;
@property NSMutableDictionary *result;

@end
