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

@property(nonatomic, assign)double timeInterval;

@end
