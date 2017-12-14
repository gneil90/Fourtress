//
//  NSManagedObject+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NSManagedObject+NestMethods.h"
@import MagicalRecord;

@implementation NSManagedObject (NestMethods)

+ (NSArray * _Nonnull)importFromArray:(NSArray * _Nullable)array {
  NSMutableArray * retVal = [NSMutableArray new];

  for (NSDictionary * info in array) {
    NSManagedObject * object = [self MR_importFromObject:info];
    [retVal addObject:object];
  }
  
  //to be sure that we are passing immutable object
  
  return [NSArray arrayWithArray:retVal];
}

@end
