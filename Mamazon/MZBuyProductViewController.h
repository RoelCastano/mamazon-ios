//
//  MZBuyProductViewController.h
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZProduct.h"

@interface MZBuyProductViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) MZProduct* product;

-(id)initWithProduct:(MZProduct*)product;

@end
