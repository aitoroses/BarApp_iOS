//
//  HomeViewController.h
//  BarProject
//
//  Created by Aitor Oses on 05/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
#import "MWFSlideNavigationViewController.h"

@interface HomeViewController : UIViewController <UIWebViewDelegate, MWFSlideNavigationViewControllerDelegate, MWFSlideNavigationViewControllerDataSource>

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

-(void)close:(id)sender;

@end
