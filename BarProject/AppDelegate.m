//
//  AppDelegate.m
//  BarProject
//
//  Created by Aitor Oses on 04/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "AppDelegate.h"
#import "LogInController.h"
#import "MWFSlideNavigationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        
    // ***** Initialize Data
    
    self.dict = [[NSMutableDictionary alloc] init];
    
    // ***** Setting the login tab
    
    // Create your login view controller
    LogInController *loginVC = [[LogInController alloc] initWithNibName:nil bundle:nil];
    // Set main navigation controller initialized with the login ViewController
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    // Create a tab bar item
    UITabBarItem *vipItem = [[UITabBarItem alloc] initWithTitle:@"VIP" image:nil tag:0];    
    // Set the tab bar item
    self.navigationController.tabBarItem = vipItem;
    // Get a reference to the tab bar controller
    UITabBarController *tbC = (UITabBarController*)self.window.rootViewController;
    // Get the current view controllers in your tab bar
    NSMutableArray *currentItems = [NSMutableArray arrayWithArray:tbC.viewControllers];
    // Add your login controller
    [currentItems addObject:self.navigationController];
    tbC.viewControllers = [NSArray arrayWithArray:currentItems];
    
    // ***** STYLE for NavigationBar
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // ***** Setting the SlideViewController for Home View
  
    // Get the main controller Home
    UIViewController *home = [tbC.viewControllers objectAtIndex:0];
    self.home = (HomeViewController *) home;
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:home];
    navCtl.navigationBar.barStyle = UIBarStyleBlack;
    // Setup slide navigation view controller instance
    MWFSlideNavigationViewController *slideNavCtl = [[MWFSlideNavigationViewController alloc] initWithRootViewController:home];
    slideNavCtl.panEnabled = YES;
    // Initialize the Slide View Controller Delegate and datasource *** Lo hacemos aqui por que el storyboard se carga antes de que se cree nuestro SlideViewController
    slideNavCtl.delegate = home;
    slideNavCtl.dataSource = home;
    // Set tab bar item programatically
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    // Set the tab bar item
    slideNavCtl.tabBarItem = homeItem;
    // Configure slide navigation view as default for home tab
    [currentItems replaceObjectAtIndex:0 withObject:slideNavCtl];
    // Set the tab controllers another time
    tbC.viewControllers = [NSArray arrayWithArray:currentItems];
    
    // Configure delegate for TabBar for disabling
    [tbC setDelegate:tbC];
    
    
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
