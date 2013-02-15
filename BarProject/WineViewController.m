//
//  WineViewController.m
//  BarProject
//
//  Created by Aitor Oses on 15/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "WineViewController.h"
#import "Common.h"
#import "AFNetworking.h"

@interface WineViewController ()

@end

@implementation WineViewController

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
    
    // Titulo
    self.title = self.wine[@"name"];
    
    // Imagen del vino
    NSString *path = [NSString stringWithFormat:@"%@%@",
                      pathToWine,
                      self.wine[@"picture"]];
    NSURL *url = [[NSURL alloc] initWithString:path];
    [self.pictureView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    // Mostrar datos
    self.nameLabel.text = self.wine[@"name"];
    self.descriptionLabel.text = self.wine[@"description"];
    self.ratingLabel.text = self.wine[@"rating"];
    self.categoryLabel.text = self.wine[@"category"];
    self.priceLabel.text = [NSString stringWithFormat:@"%@%@", self.wine[@"price"], @" €"];



    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPictureView:nil];
    [self setNameLabel:nil];
    [self setDescriptionLabel:nil];
    [self setRatingLabel:nil];
    [self setCategoryLabel:nil];
    [self setPriceLabel:nil];
    [super viewDidUnload];
}
@end
