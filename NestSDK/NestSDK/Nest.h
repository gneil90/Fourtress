//
//  Nest.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NTRestClient.h"
#import "NTAuthViewController.h"
#import "NTAuthorizationService.h"
#import "NTConstants.h"
#import "NSManagedObjectModel+NestMethods.h"
#import "NTStructure+CoreDataClass.h"
#import "NTThermostat+CoreDataClass.h"
#import "NTBasePollService.h"
#import "NTDeviceApiService.h"
#import "NSString+NestMethods.h"
#import "UIViewController+NestMethods.h"

@interface Nest : NSObject

/**
 Sets the level of logging to display.
 By default:
 - it is set to `NTLogLevelNone`
 @param logLevel Log level to set.
 */

+ (void)setDebugLevel:(NTLogLevel)logLevel;

/**
 Sets the properties of your project obtained in https://console.developers.nest.com/products. These values will be used in NTAuthorizationService to exchange PIN to AccessToken
 @param clientId Identifies your product to the API
 @param clientSecret Unique string assigned to your product; this value should never be shared
 */
+ (void)setClientId:(NSString * _Nonnull)clientId
       clientSecret:(NSString * _Nonnull)clientSecret;

@end
