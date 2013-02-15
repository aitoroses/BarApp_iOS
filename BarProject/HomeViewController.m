//
//  HomeViewController.m
//  BarProject
//
//  Created by Aitor Oses on 05/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost/laravel/public/API/information.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    //[self setDescription:nil];
    //[self setChart:nil];
    //[self setTimeLabel:nil];
    [super viewDidUnload];
}
@end
