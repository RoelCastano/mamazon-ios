//
//  MZProductMapping.h
//  Mamazon
//
//  Created by Roel Castano on 5/15/15.
//  Copyright (c) 2015 api. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZMappingManager.h"

@interface MZProductMapping : NSObject <MZMapper>

// ILMapper
+ (NSArray *) responseDescriptors;
+ (NSArray *) requestDescriptors;
+ (RKObjectMapping *) mapping;
+ (RKObjectMapping *)mappingWithRelationships;
+ (void)addRelationships;

@end
