//
//  NTAuthViewModel.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTAuthViewModel : NSObject

/// Defines if authentication is in process.
@property (assign, nonatomic) BOOL isBusy;

/// Defines latest pinCode entered by user
@property (strong, nonatomic, nullable) NSString * pinCode;

/// Defines if user is authorized
@property (assign, nonatomic) BOOL isAuthorized;

/// Defines latest error of latest operation, can be nil
@property (strong, nonatomic, nullable) NSError * error;
@end
