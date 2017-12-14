//
//  NTDeviceApiService.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <NestSDK/NestSDK.h>
#import "NTStructure+CoreDataClass.h"

// New to ReactiveCocoa? It is documented like crazy. Check out: https://github.com/ReactiveCocoa/ReactiveObjC
@import ReactiveObjC;

@interface NTDeviceApiService : NTBaseService

// Structure

/*
 * Gets all structures available.
 */

- (RACSignal * _Nonnull)fetchStructures;

// Devices

/*
 * Gets thermostat's properties.
 * @param thermostatId An identifier of thermostat
 */
- (RACSignal * _Nonnull)fetchThermostat:(NSString * _Nonnull)thermostatId;

/*
 * Sets target temperature in Celcius for thermostat.
 * @param targetTemp A target temperature to be set
 * @param thermostatId An identifier of thermostat
 */
- (RACSignal * _Nonnull)setTargetTemperature:(NSInteger)targetTemp forThermostat:(NSString * _Nonnull)thermostatId;


@end
