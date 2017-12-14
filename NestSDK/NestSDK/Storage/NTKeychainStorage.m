//
//  NTKeychainStorage.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTKeychainStorage.h"
#import "KeychainItemWrapper.h"

NSString * const NTAccessToken = @"NTAccessToken";
NSString * const NTAccessTokenExpiresIn = @"NTAccessTokenExpiresIn";

@implementation NTKeychainStorage

+ (void)resetAccessToken {
  [self clearKeychainForKey:NTAccessToken];
  [self clearKeychainForKey:NTAccessTokenExpiresIn];
}

/// Retrieves access token from keychain. Returns nil if does not exists
+ (NSString * _Nullable)getAccessToken {
  NSString * accessTokenString = [self keychainObjectForKey:NTAccessToken];
  if (accessTokenString.length > 0) {
    return accessTokenString;
  }
  
  return nil;
}

/// Saves access token in Keychain.
+ (void)setAccessToken:(NSString * _Nullable)accessToken {
  [self setObject:accessToken forKey:NTAccessToken];
}

/// Retrieves time interval until the expiration
+ (NSNumber * _Nullable)getAccessTokenExpiresIn {
  return [self keychainObjectForKey:NTAccessTokenExpiresIn];
}

/// Sets timeinterval to expire in Keychain
+ (void)setAccessTokenExpiresIn:(NSNumber * _Nullable)expiresIn {
  [self setObject:expiresIn forKey:NTAccessTokenExpiresIn];
}

/**
 Retrieves object in Keychain for key
 @param key Key identifier
 */

+ (id)keychainObjectForKey:(NSString *)key {
  if (!key)
    return nil;
  
  KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
  id res = [keychainWrapper objectForKey:(__bridge_transfer id) kSecAttrAccount];
  
  if (res != nil &&
      [res isKindOfClass:[NSString class]] &&
      [res length] > 0 &&
      ![[keychainWrapper objectForKey:(__bridge id) kSecAttrAccessible] isEqualToString:(__bridge id)kSecAttrAccessibleAlways]) { //required for old users who update the app and use accessToken already
    [keychainWrapper setObject:(__bridge id)kSecAttrAccessibleAlways forKey:(__bridge id)kSecAttrAccessible];
  }
  
  if (!res) {
    NTLogDebug(@"Unable to retrieve keychain item: %@", key);
  }
  return res;
}

/**
 Saves object in Keychain for key
 @param obj Value to store in keychain
 @param key Key identifier
 */

+ (void)setObject:(id)obj forKey:(NSString *)key {
  if (!obj || !key)
    return;
  
  KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
  [keychainWrapper setObject:obj forKey:(__bridge id) kSecAttrAccount];
  [keychainWrapper setObject:(__bridge id)kSecAttrAccessibleAlways forKey:(__bridge id)kSecAttrAccessible];
}

/**
 Clears object in Keychain for key
*/
+ (void)clearKeychainForKey:(NSString *)key {
  if (!key)
    return;
  
  KeychainItemWrapper *keychainWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
  [keychainWrapper resetKeychainItem];
}

@end
