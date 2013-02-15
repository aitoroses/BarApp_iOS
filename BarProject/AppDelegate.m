//
//  AppDelegate.m
//  BarProject
//
//  Created by Aitor Oses on 04/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create your settings view controller
    LogInController *loginVC = [[LogInController alloc] initWithNibName:nil bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    // Create a tab bar item
    //UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:@"VIP" image:[UIImage imageNamed:@"SettingsTabImage" tag:0];
    
    // Set the tab bar item
    UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:@"VIP" image:nil tag:0];
                                  self.navigationController.tabBarItem = vipItem;
                                  
                                  // Get a reference to the tab bar controller
                                  UITabBarController *tbC = (UITabBarController*)self.window.rootViewController;
                                  
                                  // Get the current view controllers in your tab bar
                                  NSMutableArray *currentItems = [NSMutableArray arrayWithArray:tbC.viewControllers];
                                  
                                  // Add your settings controller
                                  [currentItems addObject:self.navigationController];
                                  tbC.viewControllers = [NSArray arrayWithArray:currentItems];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
