//
//  NTThermostat+CoreDataClass.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//
//

#import "NTThermostat+CoreDataClass.h"


@import MagicalRecord;

@implementation NTThermostat

+ (NTThermostat * _Nullable)findFirst {
  return [NTThermostat MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"nameLong != nil"]];
}

@end
