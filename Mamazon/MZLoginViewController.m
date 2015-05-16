//
//  MZLoginViewController.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZLoginViewController.h"
#import "MZUser.h"
#import "AppDelegate.h"
#import "MZApiClient.h"
#import "MZProductsTableViewController.h"

@interface MZLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;

@end

@implementation MZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [MZUser authenticateWithEmail:self.usernameTextView.text
                         password:self.passwordTextView.text
                          success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                              MZUser *currentUser = mappingResult.firstObject;
                              AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
                              appDelegate.currentUser = currentUser;
                              
                              [MZApiClient setAuthorizationToken:currentUser.authenticationToken];
                              NSLog(@"............................");
                              NSLog(@"%@", currentUser.authenticationToken);
                              NSLog(@"............................");
                              NSLog(@"............................");

                              MZProductsTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"rootVC"];

                              [self presentViewController:vc animated:YES completion:nil];
                          } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                              /*hud.labelText = @"Bad credentials";
                              NSTimeInterval timeInterval = 1.0;
                              [hud hide:YES afterDelay:timeInterval];
*/
                          }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
