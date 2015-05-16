//
//  MZBuyProductViewController.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZBuyProductViewController.h"
#import "MZProduct.h"

@interface MZBuyProductViewController ()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productAvailableLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@end

@implementation MZBuyProductViewController

-(id)initWithProduct:(MZProduct*)prod;
{
    self = [super init];
    
    if (self) {
        self.product = prod;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.productNameLabel setText:self.product.name];
    [self.productAvailableLabel setText:[self.product.available stringValue]];
    [self.priceLabel setText:[NSString stringWithFormat:@"$%@", self.product.price]];
    [self.totalPriceLabel setText:[NSString stringWithFormat:@"$%@",self.product.price]];
    NSURL *url = [NSURL URLWithString:self.product.imageUrl];
    [self.productImage setImageWithURL:url];
    
    self.amountTextField.delegate = self;

    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    double x = [textField.text doubleValue];
    double y = [self.product.price doubleValue];
    double total = x*y;
    [self.totalPriceLabel setText:[NSString stringWithFormat:@"$%@",[NSNumber numberWithDouble:total]]];

}

- (IBAction)buyButtonPressed:(id)sender {
    if (([self.product.available integerValue] - [self.amountTextField.text integerValue]) >= 0) {
        self.product.available = [NSNumber numberWithInt:[self.product.available integerValue] - [self.amountTextField.text integerValue]];
        [self.product updateProductWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            self.product = mappingResult.firstObject;
            self.productAvailableLabel.text = [self.product.available stringValue];
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            NSLog(@"Couldnt update!");
        }];

    }
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
