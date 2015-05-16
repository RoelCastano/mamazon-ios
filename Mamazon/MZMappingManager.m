//
//  ILMappingManager.m
//
//  Created by Adrian Gonzalez on 9/18/13.
//  Copyright (c) 2013 Icalia Labs. All rights reserved.
//

#import "MZMappingManager.h"
#import "MZApiClient.h"
#import "MZUserMapping.h"
#import "MZObjectRequestOperation.h"
#import "MZProductMapping.h"
#import <RestKit/RestKit.h>

@implementation MZMappingManager

+ (void)setup
{
    RKObjectManager *manager = [[RKObjectManager alloc] initWithHTTPClient:[MZApiClient sharedClient]];
    [RKObjectManager setSharedManager:manager];
    
    [[RKObjectManager sharedManager] registerRequestOperationClass:[MZObjectRequestOperation class]];
    
    NSArray *mappingClasses = @[[MZProductMapping class], [MZUserMapping class]];
    
    // preload mappings
    [self preloadMappings:mappingClasses];
    
    // preload relationships
    [self preloadRelatioships:mappingClasses];
    
    //Response Descriptors
    [self addResponseDescriptorsForMappings:mappingClasses];
    
    //Request Descriptors
    [self addRequestDescriptorsForMappings:mappingClasses];
    
    //Pagination
    [self addPaginationMapping];
    
}

+ (NSIndexSet *)statusCodeSet {
    return RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
}

+ (void)addResponseDescriptorsForMappings:(NSArray *)mappingClasses {
    for (id<MZMapper> mappingClass in mappingClasses) {
        [[RKObjectManager sharedManager] addResponseDescriptorsFromArray:[mappingClass responseDescriptors]];
    }
}

+ (void)addRequestDescriptorsForMappings:(NSArray *)mappingClasses {
    for (id<MZMapper> mappingClass in mappingClasses) {
        [[RKObjectManager sharedManager] addRequestDescriptorsFromArray:[mappingClass requestDescriptors]];
    }
}

+ (void)addPaginationMapping
{
    RKObjectMapping *paginationMapping = [RKObjectMapping mappingForClass:[RKPaginator class]];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [paginationMapping addAttributeMappingsFromDictionary:@{
                                                            @"meta.pagination.per_page":@"perPage",
                                                            @"meta.pagination.total_pages":@"pageCount",
                                                            @"meta.pagination.total_objects":@"objectCount"
                                                            }];
    
    [objectManager setPaginationMapping:paginationMapping];
}

+(void)preloadMappings:(NSArray *)mappingClasses
{
    for (id<MZMapper> mappingClass in mappingClasses) {
        [mappingClass mapping];
    }
}

+(void)preloadRelatioships:(NSArray *)mappingClasses
{
    for (id<MZMapper> mappingClass in mappingClasses) {
        [mappingClass addRelationships];
    }
}

@end