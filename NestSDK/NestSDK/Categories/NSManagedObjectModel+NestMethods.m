//
//  NSManagedObjectModel+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NSManagedObjectModel+NestMethods.h"
#import "NTStructure+CoreDataClass.h"


@implementation NSManagedObjectModel (NestMethods)

+ (NSManagedObjectModel * _Nullable)nt_defaultObjectModel {
  NSBundle * bundle = [NSBundle bundleForClass:[NTStructure class]];
  return [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
}


@end
