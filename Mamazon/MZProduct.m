//
//  MZProduct.m
//  Mamazon
//
//  Created by Roel Castano on 5/14/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZProduct.h"

@implementation MZProduct

+(void)getProductsWithSuccess:(RKSuccessBlock)success
                      failure:(RKFailureBlock)failure{
    [[RKObjectManager sharedManager] getObject:[[MZProduct alloc] init]
                                          path:@"products"
                                    parameters:nil
                                       success:success
                                       failure:failure];
}

-(void)updateProductWithSuccess:(RKSuccessBlock)success
                        failure:(RKFailureBlock)failure{
    [[RKObjectManager sharedManager] patchObject:self
                                          path:[NSString stringWithFormat:@"products/%@", self.productId]
                                    parameters:nil
                                       success:success
                                       failure:failure];
}


@end
