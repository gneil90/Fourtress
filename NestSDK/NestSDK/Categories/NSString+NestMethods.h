//
//  NSString+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NestMethods)

/// Returns localized string and receiver used as a key. Sample usage: [@"key" localized]
- (NSString * _Nullable)localized;

@end
