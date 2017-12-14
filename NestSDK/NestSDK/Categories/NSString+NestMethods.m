//
//  NSString+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NSString+NestMethods.h"

@implementation NSString (NestMethods)

- (NSString * _Nullable)localized {
  return NSLocalizedString(self, nil);
}

@end
