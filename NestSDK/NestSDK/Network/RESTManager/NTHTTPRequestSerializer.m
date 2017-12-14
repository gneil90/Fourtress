//
//  NTHTTPRequestSerializer.m
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTHTTPRequestSerializer.h"
#import "NTQueryStringPair.h"
#import "NTConstants.h"

@import UIKit;

@interface NTHTTPRequestSerializer()

@property (assign, nonatomic) NSStringEncoding stringEncoding;
@property (strong, nonatomic) NSMutableDictionary * mutableHttpRequestHeaders;
@property (strong, nonatomic) dispatch_queue_t requestHeaderModificationQueue;

@end


@implementation NTHTTPRequestSerializer

+ (instancetype)serializer {
  return [[self alloc] init];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    
    self.stringEncoding = NSUTF8StringEncoding;
    
    self.mutableHttpRequestHeaders = [NSMutableDictionary dictionary];
    self.requestHeaderModificationQueue = dispatch_queue_create("com.nest.requestHeadersModification", DISPATCH_QUEUE_CONCURRENT);

    // Accept-Language HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
    // Quote:
    // For example,
    //
    // Accept-Language: da, en-gb;q=0.8, en;q=0.7
    // would mean: "I prefer Danish, but will accept British English and other types of English."
    //
    NSMutableArray * acceptedLanguages = [NSMutableArray array];
    [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      float q = 1.0f - (idx * 0.1f);
      [acceptedLanguages addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
      *stop = q <= 0.5f;
    }];
    
    [self setValue:[acceptedLanguages componentsJoinedByString:@", "] forHTTPHeaderField:HTTPHeaderAcceptLanguage];

    [self setValue:HTTPContentTypeJSON forHTTPHeaderField:HTTPHeaderContentType];
    
    NSString * userAgent = [NSString stringWithFormat:@"%@; iOS %@;", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
    [self setValue:userAgent forHTTPHeaderField:HTTPHeaderUserAgent];
    
    // HTTP Method Definitions; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html
    self.allowedHttpMethodsToEncodeParameters = [NSSet setWithObjects:HTTPMethodGET, HTTPMethodHEAD, HTTPMethodDELETE, nil];
  }
  
  return self;
}

#pragma mark- HTTPHeaders

- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token {
  [self setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:HTTPHeaderAuthorization];
}

- (void)clearAuthorizationHeader {
  dispatch_barrier_async(self.requestHeaderModificationQueue, ^{
    [self.mutableHttpRequestHeaders removeObjectForKey:HTTPHeaderAuthorization];
  });
}

- (NSDictionary *)httpRequestHeaders {
  NSDictionary __block *value;
  dispatch_sync(self.requestHeaderModificationQueue, ^{
    value = [NSDictionary dictionaryWithDictionary:self.mutableHttpRequestHeaders];
  });
  return value;
}

- (NSString *)valueForHTTPHeaderField:(NSString *)field {
  NSString __block *value;
  dispatch_sync(self.requestHeaderModificationQueue, ^{
    value = [self.mutableHttpRequestHeaders valueForKey:field];
  });
  return value;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
  //Dispatch barriers go along with custom concurrent queues. They can be used with two functions: dispach_barrier_async and dispatch_barrier_sync. These work just like dispatch_async and dispatch_sync except that, if used on a custom concurrent queue, the block that's submitted with the barrier function doesn't run concurrently with other work on that queue. Instead, it waits until anything currently executing on the queue is finished
  
  dispatch_barrier_async(self.requestHeaderModificationQueue, ^{
    [self.mutableHttpRequestHeaders setValue:value forKey:field];
  });
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error {
  NSURL *url = [NSURL URLWithString:URLString];
  
  NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:url];
  mutableRequest.HTTPMethod = method;
  
  mutableRequest = [[self createRequestBySerializing:mutableRequest withParameters:parameters error:error] mutableCopy];
  
  return mutableRequest;
}

#pragma mark - URLRequestSerialization

- (NSURLRequest *)createRequestBySerializing:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error {
  NSMutableURLRequest *mutableRequest = [request mutableCopy];
  
  [self.httpRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
    if (![request valueForHTTPHeaderField:field]) {
      [mutableRequest setValue:value forHTTPHeaderField:field];
    }
  }];
  
  NSString *query = nil;
  if (parameters) {
    query = [self queryStringFromParameters: parameters];
  }
  
  if ([self.allowedHttpMethodsToEncodeParameters containsObject:[[request HTTPMethod] uppercaseString]]) {
    if (query && query.length > 0) {
      mutableRequest.URL = [NSURL URLWithString:[[mutableRequest.URL absoluteString] stringByAppendingFormat:mutableRequest.URL.query ? @"&%@" : @"?%@", query]];
    }
  } else {
    if (parameters) {
      NSData * data;
      NSString * contentType = [self valueForHTTPHeaderField:HTTPHeaderContentType];
      if ([contentType isEqualToString:HTTPContentTypeJSON]) {
        data = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:error];
      } else if ([contentType isEqualToString:HTTPContentTypeWWWFormUrlencoded]) {
        data = [query dataUsingEncoding:self.stringEncoding];
      } else {
        
      }
      
      if (data) {
        mutableRequest.HTTPBody = data;
      }
    }
  }
  
  return mutableRequest;
}

- (NSString *)queryStringFromParameters:(NSDictionary *)parameters {
  NSMutableArray *mutablePairs = [NSMutableArray array];
  for (NTQueryStringPair *pair in [self stringPairsFromParameters:parameters]) {
    [mutablePairs addObject:[pair URLEncodedStringValue]];
  }
  
  return [mutablePairs componentsJoinedByString:@"&"];
}

- (NSArray *)stringPairsFromParameters:(NSDictionary *)parameters {
  NSArray * allKeys = [parameters allKeys];
  NSMutableArray * pairs = [[NSMutableArray alloc] initWithCapacity:parameters.count];
  
  for (NSString * key in allKeys) {
    id value = parameters[key];
    
    NTQueryStringPair * stringPair = [[NTQueryStringPair alloc] initWithField:key value:value];
    [pairs addObject:stringPair];
  }
  
  return pairs;
}

@end
