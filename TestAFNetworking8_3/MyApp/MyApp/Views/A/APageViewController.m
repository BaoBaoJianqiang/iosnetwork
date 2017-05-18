//
//  APageViewController.m
//  MyApp
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "APageViewController.h"
#import "Navigator.h"

#import "ObjectMappingLoader.h"

#import "RegisterSuccess.h"
#import "Movie.h"
#import "MovieList.h"
#import "YYModel.h"
#import "NewCinema.h"

#import "NetworkManager.h"
#import "NetService.h"

#import "BaseViewController+Extension.h"

@interface APageViewController () {
    UIButton* gotoBButton;
    UIButton* gotoCButton;
    UIButton* getMovieDetailButton;
    UIButton* getMovieListButton;
    UIButton* registerButton;
    UIButton* getSomethingWithoutParamsButton;
    UIButton* sendReportButton;
    
    UIButton* parallelButton;
    UIButton* serialButton;
}

@end

@implementation APageViewController

- (void)initVariables {
    
}

- (void)initViews {
    //1.从xib中获取View
    NSArray* list = [[NSBundle mainBundle] loadNibNamed: @"APageView" owner: self options: nil];
    self.view = list.lastObject;
    
    gotoBButton = (UIButton*)[self.view viewWithTag: 500];
    [gotoBButton addTarget: self action: @selector(gotoB) forControlEvents:UIControlEventTouchUpInside];

    gotoCButton = (UIButton*)[self.view viewWithTag: 1000];
    [gotoCButton addTarget: self action: @selector(gotoC) forControlEvents:UIControlEventTouchUpInside];
    
    getMovieDetailButton = (UIButton*)[self.view viewWithTag: 101];
    [getMovieDetailButton addTarget: self action: @selector(getMovieDetail) forControlEvents:UIControlEventTouchUpInside];
    
    getMovieListButton = (UIButton*)[self.view viewWithTag: 102];
    [getMovieListButton addTarget: self action: @selector(getMovieList) forControlEvents:UIControlEventTouchUpInside];
    
    registerButton = (UIButton*)[self.view viewWithTag: 103];
    [registerButton addTarget: self action: @selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    getSomethingWithoutParamsButton = (UIButton*)[self.view viewWithTag: 104];
    [getSomethingWithoutParamsButton addTarget: self action: @selector(getSomethingWithoutParams) forControlEvents:UIControlEventTouchUpInside];
    
    sendReportButton = (UIButton*)[self.view viewWithTag: 105];
    [sendReportButton addTarget: self action: @selector(sendReport) forControlEvents:UIControlEventTouchUpInside];
    
    parallelButton = (UIButton*)[self.view viewWithTag: 106];
    [parallelButton addTarget: self action: @selector(parallel) forControlEvents:UIControlEventTouchUpInside];
    
    serialButton = (UIButton*)[self.view viewWithTag: 107];
    [serialButton addTarget: self action: @selector(serial) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loadData {
    //调用MobileAPI，发起网络请求，获取页面初始化数据
}

- (void) gotoB {
    NSString* url = @"BPageViewController";
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setValue: @"Jianqiang" forKey: @"UserName"];
    
    [Navigator navigateTo: url withData: data];
}

- (void) gotoC {
    NSString* url = @"CPageViewController";
    [Navigator navigateTo: url];
}

-(void)serial {
    
}

-(void)parallel {
    [self getMovieList];
    [self getMovieDetail];
    [self getSomethingWithoutParams];
}

- (void) getSomethingWithoutParams {
    [NetService invoke:@"getSomethingWithoutParams"
                target:self
               success:@selector(onGetSomethingWithoutParamsSuccess:)
                  fail:@selector(showHintMessage:)];
}

- (void) sendReport {
    NSDictionary *params = @{@"cityId":@"1", @"cityId":@"2", @"cityId":@"3" };
    
    [NetService invoke:@"sendReport"
                params:params
                target:self];
}

- (void) getMovieDetail {
    //http://127.0.0.1:8888/movie/getmoviedetail?cityId=1
    
    NSDictionary *params = @{@"cityId":@"1"};

    [NetService invoke:@"getMovieDetail"
             params:params
             target:self
            success:@selector(onGetMovieDetailSuccess:)
               fail:@selector(onGetMovieDetailFail:)];
}

- (void) getMovieList {
    //http://127.0.0.1:8888/movie/getMovieList?cityid=1&showdate=20161101
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"cityId"] = @"1";
    params[@"showdate"] = @"20161101";
    
    [NetService invoke:@"getMovieList"
             params:params
             target:self
            success:@selector(onGetMovieListSuccess:)
               fail:@selector(showHintMessage:)];
}

- (void) registerUser {
    //http://127.0.0.1:8888/others/register
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"baobao";
    params[@"password"] = @"123456";

    
    
    [NetService invoke:@"registerUser"
             params:params
             target:self
            success:@selector(onRegisterUserSuccess:)
               fail:@selector(showHintMessage:)];
}

-(void)onGetMovieDetailSuccess: (id)entity {
    Movie *movie = [Movie yy_modelWithDictionary: entity];
    NSLog(movie.movieName);
}

-(void)onGetMovieDetailFail:(NSString*)errorMessage {
    //在这里自定义错误显示形式
    NSLog(errorMessage);
}

-(void)onGetMovieListSuccess: (id)entity {
    MovieList* movieList = [MovieList yy_modelWithDictionary: entity];
    Movie* movie = [movieList.movieList objectAtIndex: 0];
    NSLog(movie.movieName);
}

-(void)onRegisterUserSuccess: (id)entity {
    RegisterSuccess* registerSuccess = [RegisterSuccess yy_modelWithDictionary: entity];
    
    if([registerSuccess.isError intValue] == 0) {
        [self showHintMessage: @"注册成功"];
    } else {
        [self showHintMessage: registerSuccess.errorMessage];
    }
}

-(void)onGetSomethingWithoutParamsSuccess: (id)entity {
    MovieList* movieList = [MovieList yy_modelWithDictionary: entity];
    Movie* movie = [movieList.movieList objectAtIndex: 0];
    NSLog(movie.movieName);
}

@end
