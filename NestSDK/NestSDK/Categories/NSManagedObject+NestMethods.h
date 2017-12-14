//
//  NSManagedObject+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (NestMethods)


/// Creates or updates existings objects in core data from array of dictionary. 
+ (NSArray * _Nonnull)importFromArray:(NSArray * _Nullable)array;

@end
