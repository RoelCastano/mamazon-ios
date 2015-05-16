//
//  MZUser.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZUser.h"

@implementation MZUser

+(void)authenticateWithEmail:(NSString *)email
                    password:(NSString *)password
                     success:(RKSuccessBlock)success
                     failure:(RKFailureBlock)failure
{
    [[RKObjectManager sharedManager] postObject:[[MZUser alloc] init]
                                           path:@"sign_in"
                                     parameters:@{@"email":email,
                                                  @"password":password
                                                  }
                                        success:success
                                        failure:failure];
}

+(void)logoutWithSuccess:(RKSuccessBlock)success
                     failure:(RKFailureBlock)failure
{
    [[RKObjectManager sharedManager] deleteObject:nil
                                             path:@"sign_out"
                                       parameters:nil
                                          success:success
                                          failure:failure];
}


@end
