//
//  NTKeychainStorage.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTKeychainStorage : NSObject

/// Retrieves access token from keychain. Returns nil if does not exists
+ (NSString * _Nullable)getAccessToken;

/// Saves access token in Keychain.
+ (void)setAccessToken:(NSString * _Nullable)accessToken;

/// Retrieves time interval until the expiration
+ (NSNumber * _Nullable)getAccessTokenExpiresIn;

/// Sets timeinterval to expire in Keychain
+ (void)setAccessTokenExpiresIn:(NSNumber * _Nullable)expiresIn;

/**
 Clears object in Keychain for key
 */
+ (void)clearKeychainForKey:(NSString * _Nullable)key;

/// Clears all information related to user session
+ (void)resetAccessToken;

@end
