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
    
    // Preparar Secciones
    self.sections = @[@"Todos",@"Gran Reserva",@"Reserva",@"Crianza",@"Cosecha"];
    self.sectionSelected = self.sections[0];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
#pragma mark JSON Request

    // Peticion de los datos
    NSURL *url = [[NSURL alloc] initWithString:@"http://localhost/laravel/public/API/wines.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                             self.wineData = [[NSMutableArray alloc] initWithArray:JSON];
                                             // Pasamos la informacion al Delegate
                                             AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
                                             [appDelegate.dict setObject:self.wineData forKey:@"wines"];

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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //For each section, you must return here it's label
    if(section == 0) {
        return @"Elegir por categoria";
    } else {
        if(!self.wineData.count == 0) return @"Vinos";
        else return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) return self.sections.count;
    else return self.wineData.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *wineCellIdentifier = @"aWineCell";
    static NSString *categoryCellIdentifier = @"aCategoryCell";
    UITableViewCell *cell;

    // Seccion de Elegir por categoria
    if(indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier forIndexPath:indexPath];
        
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryCellIdentifier];
        }
        NSString *name =[NSString stringWithFormat:@"%@",
                         self.sections[indexPath.row]];
        cell.textLabel.text = name;
        if([self.sectionSelected isEqualToString:self.sections[indexPath.row]])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Seccion de Vinos
    if(indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:wineCellIdentifier forIndexPath:indexPath];
    
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wineCellIdentifier];
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
    
        
    }
    
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
    if(indexPath.section == 0)
    {
        // Seleccionar categoria
        self.sectionSelected= self.sections[indexPath.row];

        // Se toman los datos
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSMutableArray *allWines = [[NSMutableArray alloc]
                            initWithArray:[appDelegate.dict objectForKey:@"wines"]];
        NSMutableArray *wines = [[NSMutableArray alloc] init];
        
        // En caso de no seleccionar "todos"
        if(indexPath.row > 0 ) {
            for (int i = 0; i<allWines.count; i++) {
                NSDictionary *wine = [allWines objectAtIndex:i];
                if([wine[@"category"] isEqualToString:self.sectionSelected]){
                    [wines addObject:wine];
                }
            }
        }
        else wines = allWines;
        
        // Recargar tabla
        self.wineData = wines;
        [self.tableView reloadData];
        // Seccion de categorias
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        // Seccion de vinos
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]
                      withRowAnimation:UITableViewRowAnimationLeft];
        
        // Scroll the table
        // En caso de que no existan vinos, no se hara scroll y dara error
        if(self.wineData.count > 0){
            
            NSIndexPath *newIndex = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }
    if(indexPath.section == 1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"mainStoryboard" bundle:nil];
        
        WineViewController *wineVC = [sb instantiateViewControllerWithIdentifier:@"wine"];
    
        // Pass data to wineVC
    
        wineVC.wine = self.wineData[indexPath.row];
    
        //[self performSegueWithIdentifier:@"pushToWine" sender:self];
            
        [self.navigationController pushViewController:wineVC animated:YES];
    }
}

@end
