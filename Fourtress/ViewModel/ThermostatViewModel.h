//
//  ThermostatViewModel.h
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NTStructure, NTThermostat, RACSignal;

@interface ThermostatViewModel : NSObject

/// Thermostat being polled and represented
@property (strong, nonatomic, nullable) NTThermostat * thermostat;

/// Defines if refreshing the thermostat information at the moment
@property (assign, nonatomic) BOOL isRefreshing;

/// Fetch thermostat signal, not executed until someone is subscribed
- (RACSignal * _Nonnull)fetchThermostatSignal;

@end
