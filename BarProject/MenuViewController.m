//
//  MenuViewController.m
//  BarProject
//
//  Created by Aitor Oses on 01/03/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "MenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sections load
    self.sections = @[@"Bar Mô",@"Descripción",@"Nuestra Carta",@"Horario", @"Nos gusta", @"Localización"];
    
    // Navigation bar styleing
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"Menu";
    
    // TableController Style
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"MLBackground.jpg"]];
    [self.tableView setSeparatorColor:[UIColor colorWithWhite:0 alpha:0]];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aSectionCell";
    UITableViewCell *cell = nil;
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ***** Cell configuration
    
    // Text
    cell.textLabel.text = self.sections[indexPath.row];
    // Background Color
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    // Text
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [cell.textLabel setShadowColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [cell.textLabel setShadowOffset:CGSizeMake(1,1)];
    // Layer
        //  When selected
    [[cell.selectedBackgroundView layer] setMasksToBounds:YES];
    [[cell.selectedBackgroundView layer] setCornerRadius:6.0f];
        // Default
    [[cell layer] setMasksToBounds:NO];        // Efecto interesante en NO
    [[cell layer] setCornerRadius:6.0f];
    [[cell layer] setBorderColor:[[UIColor colorWithWhite:1 alpha:0.09] CGColor]];
    [[cell layer] setBorderWidth:1.0f];
    [[cell layer] setShadowColor:[[UIColor colorWithWhite:0 alpha:1] CGColor]];
    [[cell layer] setShadowOffset:CGSizeMake(0, 0)];
    [[cell layer] setShadowOpacity:1];
    [[cell layer] setShadowRadius:2.0];

    
    // ***** Return cell
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
