//
//  MZUserMapping.m
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import "MZUserMapping.h"
#import <RestKit/RestKit.h>
#import "MZUser.h"

@implementation MZUserMapping

+ (RKObjectMapping *)mapping
{
    static RKObjectMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[MZUser class]];
        [mapping addAttributeMappingsFromArray:@[@"email",@"budget"]];
        [mapping addAttributeMappingsFromDictionary:@{
                                                      @"id":@"userId",                                                      @"auth_token":@"authenticationToken"
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
    //    RKObjectMapping *mapping = [self mappingWithRelationships];
    
    /*[mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user"
     toKeyPath:@"user"
     withMapping:[ILUserMapping mappingWithRelationships]]];*/
    
}

+ (NSArray *)responseDescriptors
{
    
    RKResponseDescriptor *showDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self mappingWithRelationships]
                                                                                        method:RKRequestMethodAny
                                                                                   pathPattern:nil
                                                                                       keyPath:nil
                                                                                   statusCodes:[MZMappingManager statusCodeSet]];
    
    return @[showDescriptor];
}

+ (NSArray *)requestDescriptors
{
    RKRequestDescriptor *signInDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[[self mapping] inverseMapping]
                                                                                  objectClass:[MZUser class]
                                                                                  rootKeyPath:nil
                                                                                       method:RKRequestMethodAny];
    return @[signInDescriptor];
}

@end