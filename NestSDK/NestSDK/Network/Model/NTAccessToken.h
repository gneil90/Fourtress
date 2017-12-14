//
//  NTAccessToken.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTBaseModel.h"

@interface NTAccessToken : NTBaseModel


/// Security credentials for a login session and which identifies the user
@property (strong, nonatomic) NSString <Optional> * accessToken;

/// Amount of interval in seconds left until expiration
@property (strong, nonatomic) NSNumber <Optional> * expiresIn;

@end
