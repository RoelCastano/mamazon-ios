//
//  MZProduct.h
//  Mamazon
//
//  Created by Roel Castano on 5/14/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZMappingManager.h"

@interface MZProduct : NSObject

@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *shortDescription;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *available;

+(void)getProductsWithSuccess:(RKSuccessBlock)success
                      failure:(RKFailureBlock)failure;

-(void)updateProductWithSuccess:(RKSuccessBlock)success
             failure:(RKFailureBlock)failure;

@end
