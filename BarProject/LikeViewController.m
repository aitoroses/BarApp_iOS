//
//  LikeViewController.m
//  BarProject
//
//  Created by Aitor Oses on 04/03/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "LikeViewController.h"

@interface LikeViewController ()

@end

@implementation LikeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = @"Nos gusta";
    
    // Load UIWebView
    //NSString *urlAddress = @"http://mo.breadrollsbirthday.es/map/PinterestLike/";
    NSString *urlAddress = @"http://localhost/laravel/public/map/PinterestLike/";
    
    //Creamos el URL del object
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //Refrescar el URL del objeto
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //cargar UIWebView.
    
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self.navigationController setNavigationBarHidden:YES];

    }
    [super viewWillDisappear:animated];
}

@end
