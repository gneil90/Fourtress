//
//  Nest.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "Nest.h"
#import "NTLogger.h"
#import "NTAuthorizationService.h"
#import "NTThermostat+CoreDataClass.h"
#import "NTStructure+CoreDataClass.h"
#import <MagicalRecord/MagicalRecord.h>
#import "NSManagedObjectModel+NestMethods.h"

@implementation Nest


+ (void)setDebugLevel:(NTLogLevel)logLevel {
  [[NTLogger sharedLogger] setLogLevel:logLevel];
}

+ (void)setClientId:(NSString * _Nonnull)clientId
       clientSecret:(NSString * _Nonnull)clientSecret {
  NTAuthorizationService * service = [NTAuthorizationService sharedService];
  service.clientId = clientId;
  service.clientSecret = clientSecret;
  
  [self start];
}


/// A private method which initializes all services that needs NestSDK to run
+ (void)start {
  // Initialize core data  
}

@end
