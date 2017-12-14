//
//  NTStructure+CoreDataProperties.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import "NTStructure+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NTStructure (CoreDataProperties)

+ (NSFetchRequest<NTStructure *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *structureId;
@property (nullable, nonatomic, retain) NSSet<NTThermostat *> *thermostats;

@end

@interface NTStructure (CoreDataGeneratedAccessors)

- (void)addThermostatsObject:(NTThermostat *)value;
- (void)removeThermostatsObject:(NTThermostat *)value;
- (void)addThermostats:(NSSet<NTThermostat *> *)values;
- (void)removeThermostats:(NSSet<NTThermostat *> *)values;

@end

NS_ASSUME_NONNULL_END
