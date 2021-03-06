//
//  HomeViewController.m
//  BarProject
//
//  Created by Aitor Oses on 05/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "AFNetworking.h"
#import "Common.h"
#import "MainTabBarController.h"
#import "MenuViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Se obtiene la informacion general de la aplicación
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost/laravel/public/API/information.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             
                                             // Mostramos la informacion
                                             self.data = JSON;
                                             


                                             //[self.tableView reloadData];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                     NSError *error, id JSON) {
                                             NSLog(@"NSError: %@",error.localizedDescription);
                                         }];
    [operation start];
    
    #warning Direccion del servidor o cargar localmente
    NSString *urlAddress = @"http://localhost/laravel/public/map/responsive/";
    //NSString *urlAddress = @"http://mo.breadrollsbirthday.es/map/responsive/";
    
    //Creamos el URL del object
    
    url = [NSURL URLWithString:urlAddress];
    
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

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark WebView Delegate


-(void)webViewDidFinishLoad:(UIWebView *)webView

{
    // Does not work if strings in javascript have '/r/' character
    [self executeScript:[NSString stringWithFormat:@"change('#descriptionLabel', '%@');",   self.data[0][@"description"]]];
    [self executeScript:[NSString stringWithFormat:@"change('#chartLabel', '%@');",         self.data[1][@"description"]]];
    [self executeScript:[NSString stringWithFormat:@"change('#timeLabel', '%@');",          self.data[2][@"description"]]];
}

-(void)executeScript:(NSString *)script{
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}

#pragma mark -
#pragma mark Actions

- (void) _slide:(MWFSlideDirection)direction {
    [self.slideNavigationViewController slideWithDirection:direction];
}
- (void) slideUp:(id)sender {
    [self _slide:MWFSlideDirectionUp];
}
- (void) slideLeft:(id)sender {
    [self _slide:MWFSlideDirectionLeft];
}
- (void) slideDown:(id)sender {
    [self _slide:MWFSlideDirectionDown];
}
- (void) slideRight:(id)sender {
    [self _slide:MWFSlideDirectionRight];
}
- (void) close:(id)sender {
    [self _slide:MWFSlideDirectionNone];
}
//Eliminar Boton?
-(IBAction)slideAction:(id)sender{
    [self slideRight:sender];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MainTabBarController *tbC = (MainTabBarController*)appDelegate.window.rootViewController;
    tbC.enabled = NO;
}


#pragma mark -
#pragma mark SlideViewDelegate implementation
#define VIEWTAG_OVERLAY 1100
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller willPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {
    
    if (slideDirection == MWFSlideDirectionNone) {
        
        UIView * overlay = [self.navigationController.view viewWithTag:VIEWTAG_OVERLAY];
        [overlay removeFromSuperview];
        
    } else {
        
        UIView * overlay = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        overlay.tag = VIEWTAG_OVERLAY;
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [overlay addGestureRecognizer:gr];
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.navigationController.view addSubview:overlay];
        
    }
}
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller animateSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation
{
    UIView * overlay = [self.navigationController.view viewWithTag:VIEWTAG_OVERLAY];
    if (slideDirection == MWFSlideDirectionNone)
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    else
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
}


- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                   distanceForSlideDirecton:(MWFSlideDirection)direction
                        portraitOrientation:(BOOL)portraitOrientation
{
    if (portraitOrientation)
    {
        return 180;
    }
    else
    {
        return 100;
    }
}

#pragma mark -
#pragma mark Data source implementation

- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                      viewControllerForSlideDirecton:(MWFSlideDirection)direction
{
    MenuViewController *secCtl = [[MenuViewController alloc] init];
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:secCtl];
    return navCtl;
}
@end
