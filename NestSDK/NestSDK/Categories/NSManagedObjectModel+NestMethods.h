//
//  NSManagedObjectModel+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectModel (NestMethods)

/// looks up model in the Framework bundle
+ (NSManagedObjectModel * _Nullable)nt_defaultObjectModel;

@end
