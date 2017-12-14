//
//  NTRESTManager.m
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTRestClient.h"
#import "NTConstants.h"
#import "NTHTTPRequestSerializer.h"

@import ReactiveObjC;

@implementation NTRestClient

#pragma mark- Init

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype _Nullable)initWithBaseURL:(NSURL * _Nonnull)baseURL {
  self = [super init];

  if (self) {
    [self commonInit];
    self.baseURL = baseURL;
  }
  
  return self;
}

- (void)commonInit {
  self.requestSerializer = [NTHTTPRequestSerializer serializer];
  
  self.runsRequestImmediately = NO;
  self.allowsCellularAccess = YES;
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  config.allowsCellularAccess = self.allowsCellularAccess;
  
  self.foregroundSession = [NSURLSession sessionWithConfiguration:config];
}

#pragma mark- HTTP Methods

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      redirect:(void (^)(NSHTTPURLResponse * _Nullable responseURL))redirect
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure {
  return [self dataTaskWithHTTPMethod:HTTPMethodPOST
                            URLString:URLString
                           parameters:parameters
                             redirect:redirect
                              success:success
                              failure:failure];
}

- (nullable NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                            parameters:(id)parameters
                              redirect:(void (^)(NSHTTPURLResponse * _Nullable responseURL))redirect
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError * error))failure {
  return [self dataTaskWithHTTPMethod:HTTPMethodPUT
                            URLString:URLString
                           parameters:parameters
                             redirect:redirect
                              success:success
                              failure:failure];
}

- (nullable NSURLSessionDataTask *)GET:(NSString * _Nonnull)URLString
                            parameters:(id)parameters
                              redirect:(void (^)(NSHTTPURLResponse * _Nullable responseURL))redirect
                               success:(void (^)(id responseObject))success
                               failure:(void (^)(NSError * error))failure {
  return [self dataTaskWithHTTPMethod:HTTPMethodGET
                            URLString:URLString
                           parameters:parameters
                             redirect:redirect
                              success:success
                              failure:failure];
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                        redirect:(void (^)(id))redirect
                                         success:(void (^)(id))success
                                         failure:(void (^)(NSError *))failure {
  //TODO:
//  It is also a best practice to store the redirected location on a per user basis. In other words, after a user signs in and a redirect is received, store the firebase-apiserver03-tah01-iad01.dapi.production.nest.com:9553/ location and make all subsequent requests directly to this URI.
//
//  Storing the redirected location saves time and prevents unnecessary server load.
  

  @weakify(self)
  NSError *serializationError = nil;
  NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[self constructAbsoluteURL:URLString] parameters:parameters error:&serializationError];
  if (serializationError) {
    if (failure) {
      dispatch_async(dispatch_get_main_queue(), ^{
        failure(serializationError);
      });
    }
    
    return nil;
  }

  NSURLSessionDataTask * dataTask = [self.foregroundSession dataTaskWithRequest:request completionHandler:
   ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     @strongify(self)

     void (^failureMainThreadBlock)(NSError * err) = ^(NSError * err) {
       dispatch_async(dispatch_get_main_queue(), ^{
         failure(err);
       });
     };
     
     void (^successMainThreadBlock)(id obj) = ^(id obj) {
       dispatch_async(dispatch_get_main_queue(), ^{
         success(obj);
       });
     };
     
     NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
     NTLogDebug(@"RESTManager ResponseURL: %@ Status Code: %ld", [httpResponse URL], (long)[httpResponse statusCode]);
     
     if ([httpResponse statusCode] == HTTPStatusCodeUnAuth || [httpResponse statusCode] == HTTPStatusCodeTemporaryRedirect) {
       // Check if a returned 401 is a true 401, sometimes it's a redirect.
       //   See https://developers.nest.com/documentation/cloud/how-to-handle-redirects
       //   for more information.
       NSDictionary *responseHeaders = [httpResponse allHeaderFields];
       if ([[responseHeaders objectForKey:HTTPHeaderContentLength] isEqual: @"0"]) {
         // This is a true 401
         NTLogError(NTLoggingTagCommon, @"Invalid access token!");
         failureMainThreadBlock(error);
       } else {
         // If redirect block is nil, no need to redirect anymore. Trying to redirect.
         NTLogDebug(@"Redirecting to URL: %@", [httpResponse URL]);
         if (redirect) {
           redirect(httpResponse);
           
           NSURLSessionDataTask * dataTask = [self dataTaskWithHTTPMethod:method URLString:[[httpResponse URL] absoluteString] parameters:parameters redirect:nil success:success failure:failure];
           [dataTask resume];
         } else {
           failureMainThreadBlock(error);
         }
       }
       
     } else if (error) {
       failureMainThreadBlock(error);
     } else {
       if (data && [httpResponse statusCode] >= HTTPStatusCodeOK && [httpResponse statusCode] < HTTPStatusCodeMultipleChoices) {
         NSDictionary *requestJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
         successMainThreadBlock(requestJSON);
       } else {
         failureMainThreadBlock(nil);
       }
     }
   }];
  
  if (self.runsRequestImmediately) {
    [dataTask resume];
  }
    
  return dataTask;
}

#pragma mark- Helpers

- (NSString *)constructAbsoluteURL:(NSString *)path {
  //no need to construct if path is already an absolute url
  if ([[path lowercaseString] hasPrefix:@"http"]) {
    return path;
  }
  return [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];
}

@end
