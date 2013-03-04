//
//  AppDelegate.h
//  BarProject
//
//  Created by Aitor Oses on 04/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSMutableDictionary *dict;

// We need this property to call javascript on the webview
@property (strong, nonatomic) HomeViewController *home;

@end
