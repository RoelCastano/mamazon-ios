//
//  MZProductsTableViewController.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZProductsTableViewController.h"
#import "MZProduct.h"
#import "MZUser.h"
#import "MZApiClient.h"
#import "ProductTableViewCell.h"
#import "MZBuyProductViewController.h"

@interface MZProductsTableViewController ()
@property (strong, nonatomic) NSMutableArray *products;

@end

@implementation MZProductsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"START");

    [MZProduct getProductsWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.products = [NSMutableArray arrayWithArray:mappingResult.array];
        [self.tableView reloadData];
        NSLog(@"%@",self.products);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error loading products");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutButtonPressed:(id)sender {
    [MZUser logoutWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [MZApiClient clearAuthorizationToken];
        NSLog(@"Logged out successfully!");
        [self dismissViewControllerAnimated:YES completion:nil];

    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Couldn't logout");
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"# of Products: %lu", (unsigned long)self.products.count);
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productCell" forIndexPath:indexPath];
    
    MZProduct *product = [self.products objectAtIndex:indexPath.row];
    
    [cell.nameLabel setText:product.name];
    [cell.descriptionLabel setText:product.shortDescription];
    [cell.priceLabel setText:[product.price stringValue]];
    
    NSURL *url = [NSURL URLWithString:product.imageUrl];
    [cell.image setImageWithURL:url];
    
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MZBuyProductViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"buyProductVC"];
    vc.product = [self.products objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
