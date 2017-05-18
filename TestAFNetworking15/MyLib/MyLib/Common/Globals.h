//
//  Globals.h
//  MyApp
//
//  Created by jianqiang on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

+(Globals*)getInstance;

//时间校准
@property(nonatomic, assign)double timeInterval;

//Cookie
@property(nonatomic, strong)NSString* cookie;

@end
