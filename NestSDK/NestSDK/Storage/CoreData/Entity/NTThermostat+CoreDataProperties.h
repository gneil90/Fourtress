//
//  NTThermostat+CoreDataProperties.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import "NTThermostat+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NTThermostat (CoreDataProperties)

+ (NSFetchRequest<NTThermostat *> *)fetchRequest;

@property (nonatomic) int32_t ambientTemperatureC;
@property (nullable, nonatomic, copy) NSString *deviceId;
@property (nonatomic) int32_t humidity;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nameLong;
@property (nonatomic) int32_t targetTemperatureC;
@property (nullable, nonatomic, copy) NSString *structureId;

@end

NS_ASSUME_NONNULL_END
