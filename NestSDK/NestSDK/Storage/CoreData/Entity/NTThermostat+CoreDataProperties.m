//
//  NTThermostat+CoreDataProperties.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import "NTThermostat+CoreDataProperties.h"

@implementation NTThermostat (CoreDataProperties)

+ (NSFetchRequest<NTThermostat *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NTThermostat"];
}

@dynamic ambientTemperatureC;
@dynamic deviceId;
@dynamic humidity;
@dynamic name;
@dynamic nameLong;
@dynamic targetTemperatureC;
@dynamic structureId;

@end
