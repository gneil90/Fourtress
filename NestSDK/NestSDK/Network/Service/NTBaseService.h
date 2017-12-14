//
//  NTBaseService.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTRestClient.h"

@protocol NTBaseService

- (NSURL * _Nonnull)baseURL;

@end

@interface NTBaseService : NSObject <NTBaseService>

/**
 * Get the shared service singleton.
 * @return The singleton object
 */

+ (instancetype _Nonnull)sharedService;

/// Rest client which responsible for API calls
@property (readonly, nonatomic, nonnull) NTRestClient * restClient;

@end
