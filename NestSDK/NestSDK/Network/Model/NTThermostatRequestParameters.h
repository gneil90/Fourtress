//
//  NTThermostat.h
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTDeviceRequestParameters.h"

@interface NTThermostatRequestParameters : NTDeviceRequestParameters

/// Time of the last successful interaction with the Nest service, in ISO 8601 format
@property (strong, nonatomic) NSString <Optional> * lastConnection;
/// System ability to cool (AC)
@property (strong, nonatomic) NSNumber <Optional> * canCool;
/// Indicates if the fan timer is engaged; used with 'fan_timer_timeout' to turn on the fan for a (user-specified) preset duration
@property (strong, nonatomic) NSNumber <Optional> * fanTimerActive;
/// Timestamp, showing when the fan timer reaches 0 (end of timer duration), in ISO 8601 format
@property (strong, nonatomic) NSNumber <Optional> * fanTimerTimeout;
/// Celsius or Fahrenheit; used with temperature display
@property (strong, nonatomic) NSString <Optional> * temperatureScale;

/// Desired temperature, displayed in whole degrees Fahrenheit (1°F)
@property (strong, nonatomic) NSString <Optional> * targetTemperatureF;
/// Desired temperature, displayed in half degrees Celsius (0.5°C)
@property (strong, nonatomic) NSNumber <Optional> * targetTemperatureC;

/// Maximum target temperature, displayed in whole degrees Fahrenheit (1°F); used with Heat • Cool mode
@property (strong, nonatomic) NSString <Optional> * targetTemperatureHighF;
/// Maximum target temperature, displayed in half degrees Celsius (0.5°C); used with Heat • Cool mode
@property (strong, nonatomic) NSString <Optional> * targetTemperatureHighC;

/// Temperature, measured at the device, in whole degrees Fahrenheit (1°f)
@property (strong, nonatomic) NSString <Optional> * ambientTemperatureF;
/// Temperature, measured at the device, in half degrees Celsius (0.5°C)
@property (strong, nonatomic) NSString <Optional> * ambientTemperatureC;

@end
