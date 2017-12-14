//
//  NTThermostat+CoreDataClass.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class NTStructure;

NS_ASSUME_NONNULL_BEGIN

@interface NTThermostat : NSManagedObject

/// Finds first thermostat saved
+ (NTThermostat * _Nullable)findFirst;

@end

NS_ASSUME_NONNULL_END

#import "NTThermostat+CoreDataProperties.h"
