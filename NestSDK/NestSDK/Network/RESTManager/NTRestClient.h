//
//  NTRESTManager.h
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTHTTPRequestSerializer.h"
#import "HTTPStatusCode.h"


@interface NTRestClient : NSObject

/**
 *allow request to route over cellular. Default: `true`
 */
@property (assign, nonatomic) BOOL allowsCellularAccess;

/**
 * Controls if NSURLSessionDataTask should be `resumed` immediately. Default: `false`
 */
@property (assign, nonatomic) BOOL runsRequestImmediately;

/**
 The URL used to construct requests from relative paths in methods
 */

@property (strong, nonatomic) NSURL * _Nonnull baseURL;

/**
* The shared session of manager
*/
@property (strong, nonatomic) NSURLSession * _Nonnull foregroundSession;

/**
 * Creates and returns instance of NTRestManager pointing to baseURL
 */

- (instancetype _Nullable)initWithBaseURL:(NSURL * _Nonnull)baseURL;

/**
 Default request factory. Defines all http headers are sent with every request and helps to create percent encoded url string from NSDictionary
 */

@property (strong, nonatomic) NTHTTPRequestSerializer * _Nonnull requestSerializer;


/**
 Creates and runs if needed (@see `runsImmediately` property) an `NSURLSessionDataTask`  with a `POST` request.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param redirect A Block to call after a redirect response.
 @param success A Block to call after the task finishes successfully.
 @param failure A Block to call after the task fails to finish, or that succeeded, but encountered an error while parsing the response data.
 */

- (nullable NSURLSessionDataTask *)POST:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                              redirect:(nullable void (^)(NSHTTPURLResponse * _Nullable resonseURL))redirect
                               success:(nullable void (^)(id _Nullable responseObject))success
                               failure:(nullable void (^)(NSError * _Nullable error))failure;

/**
 Creates and runs if needed (@see `runsImmediately` property) an `NSURLSessionDataTask`  with a `PUT` request.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param redirect A Block to call after a redirect response.
 @param success A Block to call after the task finishes successfully.
 @param failure A Block to call after the task fails to finish, or that succeeded, but encountered an error while parsing the response data.
 */

- (nullable NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                               redirect:(nullable void (^)(NSHTTPURLResponse * _Nullable resonseURL))redirect
                                success:(nullable void (^)(id _Nullable responseObject))success
                                failure:(nullable void (^)(NSError * _Nullable error))failure;

/**
 Creates and runs if needed (@see `runsImmediately` property) an `NSURLSessionDataTask` with a `GET` request.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param redirect A Block to call after a redirect response.
 @param success A Block to call after the task finishes successfully.
 @param failure A Block to call after the task fails to finish, or that succeeded, but encountered an error while parsing the response data.
 */

- (nullable NSURLSessionDataTask *)GET:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                              redirect:(nullable void (^)(NSHTTPURLResponse * _Nullable resonseURL))redirect
                               success:(nullable void (^)(id _Nullable responseObject))success
                               failure:(nullable void (^)(NSError * _Nullable error))failure;

/**
 Creates and runs if needed (@see `runsImmediately` property) an `NSURLSessionDataTask` with a HTTPMethod request.
 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client request serializer.
 @param redirect A Block to call after a redirect response.
 @param success A Block to call after the task finishes successfully.
 @param failure A Block to call after the task fails to finish, or that succeeded, but encountered an error while parsing the response data.
 */

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString * _Nonnull)method
                                       URLString:(NSString * _Nonnull)URLString
                                      parameters:(nullable id)parameters
                                        redirect:(nullable void (^)(id))redirect
                                         success:(nullable void (^)(id))success
                                         failure:(nullable void (^)(NSError *))failure;


@end
