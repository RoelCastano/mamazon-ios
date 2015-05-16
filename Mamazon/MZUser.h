//
//  MZUser.h
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MzMappingManager.h"

@interface MZUser : NSObject

@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *budget;
@property (strong, nonatomic) NSString *authenticationToken;

+ (void) authenticateWithEmail:(NSString *)email
                      password:(NSString *)password
                       success:(RKSuccessBlock)success
                       failure:(RKFailureBlock)failure;

+ (void)logoutWithSuccess:(RKSuccessBlock)success
                  failure:(RKFailureBlock)failure;

@end
