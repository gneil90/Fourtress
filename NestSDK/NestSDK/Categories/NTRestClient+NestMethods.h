//
//  NTRestClient+NestMethods.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <NestSDK/NestSDK.h>

@import ReactiveObjC;

@interface NTRestClient (NestMethods)

/**
 * Creates RACSignal for HTTP Rest API method
 * @param method An HTTP method used in contructing URL request `GET`, `POST`, `HEAD`, etc...
 * @param URLString An url path
 * @param parameters Data used to construct query or httpBody
 */

- (RACSignal * _Nonnull)restSignalWithHTTPMethod:(nonnull NSString *)method
                                       URLString:(nonnull NSString *)URLString
                                      parameters:(nullable id)parameters;

@end
