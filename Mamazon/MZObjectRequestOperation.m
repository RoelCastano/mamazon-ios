//
//  MZObjectRequestOperation.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZObjectRequestOperation.h"

@implementation MZObjectRequestOperation

- (void)setCompletionBlockWithSuccess:(void ( ^ ) ( RKObjectRequestOperation *operation , RKMappingResult *mappingResult ))success failure:(void ( ^ ) ( RKObjectRequestOperation *operation , NSError *error ))failure
{
    [super setCompletionBlockWithSuccess:^void(RKObjectRequestOperation *operation , RKMappingResult *mappingResult) {
        if (success) {
            success(operation, mappingResult);
        }
        
    }failure:^void(RKObjectRequestOperation *operation , NSError *error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFailure" object:operation];
        
        if (failure) {
            failure(operation, error);
        }
        
    }];
}


@end
