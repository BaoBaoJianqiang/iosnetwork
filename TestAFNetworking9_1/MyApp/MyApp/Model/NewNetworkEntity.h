//
//  NewNetworkEntity.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ObjectMapping;

@interface NewNetworkEntity : NSObject

@property NSNumber *isError;
@property NSNumber *errorType;
@property NSString *errorMessage;
@property NSString *result;

- (ObjectMapping *)objectMapping;

@end
