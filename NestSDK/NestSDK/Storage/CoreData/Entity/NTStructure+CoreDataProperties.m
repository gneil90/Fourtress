//
//  NTStructure+CoreDataProperties.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import "NTStructure+CoreDataProperties.h"

@implementation NTStructure (CoreDataProperties)

+ (NSFetchRequest<NTStructure *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NTStructure"];
}

@dynamic name;
@dynamic structureId;
@dynamic thermostats;

@end
