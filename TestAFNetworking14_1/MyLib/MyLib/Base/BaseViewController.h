//
//  BaseViewController.h
//  MyLib
//
//  Created by jax on 13-9-2.
//  Copyright (c) 2013年 Bao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CustomAlertWindow.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSMutableDictionary* param;

@property (nonatomic, strong) CustomAlertWindow *alertWindow;

- (void)initVariables;

- (void)initViews;

- (void)loadData;

- (void)showHintMessage: (NSString*)errorMessage;

@end
