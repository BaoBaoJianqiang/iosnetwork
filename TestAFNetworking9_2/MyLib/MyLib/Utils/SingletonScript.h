//
//  SingletonScript.h
//  DP2_6
//
//  Created by jianqiang on 16/8/4.
//  Copyright © 2016年 jianqiang. All rights reserved.
//

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname* _instance = nil;\
\
+(classname*)getInstance {\
    static dispatch_once_t token;\
    dispatch_once(&token, ^{\
        if(_instance == nil) {\
            _instance = [[self alloc] init];\
        }\
    });\
    return _instance;\
}\
\
+(id)allocWithZone:(struct _NSZone *)zone {\
    static dispatch_once_t token;\
    dispatch_once(&token, ^{\
        if(_instance == nil) {\
            _instance = [super allocWithZone:zone];\
        }\
    });\
    \
    return _instance;\
}\
\
-(instancetype)init {\
    self = [super init];\
    if(self) {\
    } \
\
    return self;\
}\
\
-(id)copy {\
    return self;\
}\
\
-(id)mutableCopy {return self;\
}