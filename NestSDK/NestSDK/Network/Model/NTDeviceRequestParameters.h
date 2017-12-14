//
//  NTDevice.h
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTBaseModel.h"

@interface NTDeviceRequestParameters : NTBaseModel
/// Device unique identifier
@property (strong, nonatomic) NSString <Optional> * deviceId;

/// Unique structure identifier
@property (strong, nonatomic) NSString <Optional> * structureId;

/// Display name of the device
@property (strong, nonatomic) NSString <Optional> * name;

/// Long display name of the device
@property (strong, nonatomic) NSString <Optional> * nameLong;

/// Device connection status with the Nest Service
@property (strong, nonatomic) NSNumber <Optional> * isOnline;

@end
