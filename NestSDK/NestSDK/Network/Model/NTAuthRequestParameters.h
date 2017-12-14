//
//  NTAuthRequestParameters.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <NestSDK/NestSDK.h>

@interface NTAuthRequestParameters : NTBaseModel

/// Identifies your product to the API
@property (strong, nonatomic, nonnull) NSString <Optional> * clientId;

/// Unique string assigned to your product; this value should never be shared
@property (strong, nonatomic, nonnull) NSString <Optional> * clientSecret;

/// Authorization PIN code
@property (strong, nonatomic, nonnull) NSString <Optional> * code;

/// Type of authorization. By default: `authorization_code`
@property (strong, nonatomic, nonnull) NSString <Optional> * grantType;

@end
