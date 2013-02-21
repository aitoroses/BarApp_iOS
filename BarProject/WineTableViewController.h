//
//  WineTableViewController.h
//  BarProject
//
//  Created by Aitor Oses on 05/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *wineData;
@property (nonatomic,strong) NSArray *sections;
@property (nonatomic,strong) NSString *sectionSelected;

@end
