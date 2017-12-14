//
//  NTAuthorizationService.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTAccessToken.h"
#import "NTBaseService.h"

@import ReactiveObjC;

@interface NTAuthorizationService : NTBaseService

/// Identifies your product to the API
@property (strong, nonatomic, nonnull) NSString * clientId;

/// Unique string assigned to your product; this value should never be shared
@property (strong, nonatomic, nonnull) NSString * clientSecret;

/// Container which has accessToken, expiresIn values
@property (strong, nonatomic, nullable) NTAccessToken * token;

/// Returns `True` if user has a valid access token
- (BOOL)isSessionValid;

/// Executes POST request if there are not any local credentials saved in the Keychain. If successfully completed, sets the accessToken and saves it to the keychain. If there are existing credentials in keychain, will immediately create a signal.
- (RACSignal * _Nonnull)authorize:(NSString * _Nonnull)pinCode;

/// Saves access token properties into the Keychain
- (void)saveAccessToken:(NTAccessToken * _Nullable)token;

/// Clears access token in the Keychain
- (void)resetAccessToken;

@end
