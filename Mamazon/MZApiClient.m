//
//  MZApiClient.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZApiClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>

static NSString * const kApiVersion = @"1";

@implementation MZApiClient

+ (instancetype)sharedClient {
    NSLog(@"%@",[NSString stringWithFormat:@"%@/", kBaseURLString]);
    static MZApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MZApiClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/", kBaseURLString]]];
    });
    
    return _sharedClient;
    
}

+ (void)setAuthorizationToken:(NSString *)accessToken
{
    NSLog(@"%@",[NSString stringWithFormat:@"%@/", kBaseURLString]);
    
    [self.sharedClient setDefaultHeader:@"Authorization" value: [NSString stringWithFormat:@"Token token=%@",accessToken]];
}

+ (void)clearAuthorizationToken
{
    [self.sharedClient setDefaultHeader:@"Authorization" value:nil];
}


- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [self setDefaultHeader:@"Accept" value:[NSString stringWithFormat: @"application/vnd.list.com+json; version=%@", kApiVersion]];
    
    return self;
}

@end
