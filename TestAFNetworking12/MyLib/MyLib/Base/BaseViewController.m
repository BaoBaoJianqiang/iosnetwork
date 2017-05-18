//
//  BaseViewController.m
//  MyLib
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (id) init {
    self = [super init];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadView {
    [self initVariables];
    [self initViews];
}

- (void)initVariables {
    
}

- (void)initViews {
    
}

- (void)loadData {
    
}

- (void)showHintMessage: (NSString*)errorMessage {
    self.alertWindow = [CustomAlertWindow aletWindowWithPositionOption:AlertWindowPositionCenter andInfoText:errorMessage];
    [self.alertWindow show];
    //设置定时器使之消失
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resignWindow) userInfo:nil repeats:NO];
}

- (void)resignWindow {
    [self.alertWindow dismiss];
    //需要消失的时候不要忘了赋值nil
    self.alertWindow = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
