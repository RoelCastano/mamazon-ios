//
//  MZApiClient.h
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "AFHTTPClient.h"
#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPClient.h>

# ifdef STAGING
static NSString * const kBaseURLString = @"http://localhost:3000/api";
# elif DEBUG
static NSString * const kBaseURLString = @"http://localhost:3000/api";
# else
static NSString * const kBaseURLString = @"http://localhost:3000/api";
# endif

@interface MZApiClient : AFHTTPClient

typedef void(^ AFSuccessBlock)(AFHTTPRequestOperation *operation, NSDictionary *responseObject);
typedef void(^ AFFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

+ (instancetype)sharedClient;
+ (void)setAuthorizationToken:(NSString *)accessToken;
+ (void)clearAuthorizationToken;


@end
