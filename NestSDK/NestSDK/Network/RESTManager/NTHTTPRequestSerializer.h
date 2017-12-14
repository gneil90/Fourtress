//
//  NTRequestSerializer.h
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NTHTTPRequestSerializer
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error;

@end

@interface NTHTTPRequestSerializer : NSObject <NTHTTPRequestSerializer>


/**
 Allowed HTTP methods for which parameters can be converted to a query string format: parameter1=value1&parameter2=value2&.... `GET`, `HEAD`, `DELETE` by default.
 */
@property (nonatomic, strong) NSSet <NSString *> *allowedHttpMethodsToEncodeParameters;

/**
 Creates and returns serializer with default parameters set
*/
+ (instancetype)serializer;

/**
 NTHTTPRequestSerializer protocol method
 Creates a mutable request instance with the specified HTTP method, URL string, parameters as query or http body
 */

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error;

/**
 Sets the "Authorization" HTTP header. This overwrites any existing value for this header.
*/
- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token;

/**
 Sets value for HTTP header field. This overwrites any existing value for this header.
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 Clears "Authorization" HTTP header
 */
- (void)clearAuthorizationHeader;

@end
