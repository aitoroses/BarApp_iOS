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
                                             self.descriptionLabel.text = JSON[0][@"description"];
                                             self.chartLabel.text = JSON[1][@"description"];
                                             self.timeLabel.text = JSON[2][@"description"];


                                             //[self.tableView reloadData];
                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                     NSError *error, id JSON) {
                                             NSLog(@"NSError: %@",error.localizedDescription);
                                         }];
    [operation start];
    
    // Llamamos a la funcion del mapa
    [NSThread detachNewThreadSelector:@selector(loadMap) toTarget:self withObject:nil];
    [self.webView setScalesPageToFit:NO];

    //[self.myMapView setShowsUserLocation:YES];
    //[NSThread detachNewThreadSelector:@selector(displayMYMap) toTarget:self withObject:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDescriptionLabel:nil];
    [self setChartLabel:nil];
    [self setTimeLabel:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Map functions

-(void)loadMap{
    NSString *urlAddress = map;

    
    //Creamos el URL del object
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //Refrescar el URL del objeto
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //cargar UIWebView.
    
    [self.webView loadRequest:requestObj];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom = 2"];
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
#pragma mark Delegate implementation


- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller
                   distanceForSlideDirecton:(MWFSlideDirection)direction
                        portraitOrientation:(BOOL)portraitOrientation
{
    if (portraitOrientation)
    {
        return 100;
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
    UITableViewController * secCtl = [[UITableViewController alloc] init];
    UINavigationController * navCtl = [[UINavigationController alloc] initWithRootViewController:secCtl];
    return navCtl;
}
@end
