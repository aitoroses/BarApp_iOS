//
//  WineTableViewController.m
//  BarProject
//
//  Created by Aitor Oses on 05/02/13.
//  Copyright (c) 2013 MurrayApps. All rights reserved.
//

#import "WineTableViewController.h"
#import "WineViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Common.h"

@interface WineTableViewController ()

@end

@implementation WineTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost/laravel/public/API/wines.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             self.wineData = JSON;
                                             // Pasamos la informacion al Delegate
                                             AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                             [appDelegate.dict setObject:JSON forKey:@"wines"];

                                             [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.wineData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aWineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *name =[NSString stringWithFormat:@"%@",
                     self.wineData[indexPath.row][@"name"]];
    
    cell.textLabel.text = name;
    
    //Imagen para cell
    NSString *path = [NSString stringWithFormat:@"%@%@",
                     pathToWineThumb,
                     self.wineData[indexPath.row][@"picture"]];
    
    NSURL *url = [[NSURL alloc] initWithString:path];

    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    //Devuelve la celda
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:nil];
        
    WineViewController *wineVC = [sb instantiateViewControllerWithIdentifier:@"wine"];
    
    // Pass data to wineVC
    
    wineVC.wine = self.wineData[indexPath.row];
    
    //[self performSegueWithIdentifier:@"pushToWine" sender:self];
        
    [self.navigationController pushViewController:wineVC animated:YES];
    
}

@end
