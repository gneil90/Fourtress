//
//  NSError+NestMethods.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NSError+NestMethods.h"
#import "NTConstants.h"

@implementation NSError (NestMethods)

+ (NSError *)errorWithMessage:(NSString * _Nonnull)message code:(NSInteger)code {
  return [NSError errorWithDomain:NTDomain code:code userInfo:@{NSLocalizedDescriptionKey : message}];
}

@end
