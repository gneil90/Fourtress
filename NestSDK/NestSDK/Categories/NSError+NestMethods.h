//
//  NSError+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (NestMethods)

/*
 * Creates error with NTDomain and localizedDescription
 * @param message A message which will be passed as `localizedDescription` key in userInfo
 * @param code An error code
 */
+ (NSError * _Nonnull)errorWithMessage:(NSString * _Nonnull)message code:(NSInteger)code;

@end
