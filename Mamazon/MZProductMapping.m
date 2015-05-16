//
//  MZProductMapping.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZProductMapping.h"
#import "MZProduct.h"
#import "MZMappingManager.h"
#import <RestKit/RestKit.h>

@implementation MZProductMapping

+ (RKObjectMapping *)mapping
{
    static RKObjectMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MZProduct class]];
        [mapping addAttributeMappingsFromArray:@[@"name", @"price", @"available"]];
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"id": @"productId",
                                                      @"image_url":@"imageUrl",
                                                      @"description":@"shortDescription"
                                                      }];
        _mapping = mapping;
    });
    
    return _mapping;
}

+(RKObjectMapping *)mappingWithRelationships
{
    static RKObjectMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mapping = [[self mapping] copy];
    });
    return _mapping;
}

+(void)addRelationships
{
    //RKObjectMapping *mapping = [self mappingWithRelationships];
    
    /* [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
     toKeyPath:@"user"
     withMapping:[ILUserMapping mappingWithRelationships]]];*/
    
}

+ (NSArray *)responseDescriptors
{
    RKResponseDescriptor *indexDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self mappingWithRelationships]
                                                                                         method:RKRequestMethodGET
                                                                                    pathPattern:@"products"
                                                                                        keyPath:@"products"
                                                                                    statusCodes:[MZMappingManager statusCodeSet]];
    
    RKResponseDescriptor *showDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self mappingWithRelationships]
                                                                                        method:RKRequestMethodAny
                                                                                   pathPattern:nil
                                                                                       keyPath:@"product"
                                                                                   statusCodes:[MZMappingManager statusCodeSet]];
    
    RKResponseDescriptor *updateDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self mappingWithRelationships]
                                                                                          method:RKRequestMethodPATCH
                                                                                     pathPattern:@"products/:id"
                                                                                         keyPath:@"product"
                                                                                     statusCodes:[MZMappingManager statusCodeSet]];

    return @[indexDescriptor, showDescriptor, updateDescriptor];
}

+ (NSArray *)requestDescriptors
{
    RKRequestDescriptor *createDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[[self mapping] inverseMapping]
                                                                                  objectClass:[MZProduct class]
                                                                                  rootKeyPath:@"product"
                                                                                       method:RKRequestMethodAny];
    
    return @[createDescriptor];
}

@end
