//
//  NTAuthorizationService.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTAuthorizationService.h"
#import "NTRestClient.h"
#import "NTConstants.h"
#import "NTAccessToken.h"
#import "NTKeychainStorage.h"
#import "NTAuthRequestParameters.h"
#import "NTRestClient+NestMethods.h"

@import ReactiveObjC;

@interface NTAuthorizationService()

@end

@implementation NTAuthorizationService

+ (instancetype)sharedService {
  static dispatch_once_t once;
  static NTAuthorizationService *instance;
  
  dispatch_once(&once, ^{
    instance = [[NTAuthorizationService alloc] init];
  });
  
  return instance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [self.restClient.requestSerializer setValue:HTTPContentTypeWWWFormUrlencoded
                             forHTTPHeaderField:HTTPHeaderContentType];    
    NSString * accessTokenString = [NTKeychainStorage getAccessToken];
    NSNumber * accessTokenExpiresIn = [NTKeychainStorage getAccessTokenExpiresIn];
    
    if (accessTokenString) {
      NTAccessToken * token = [NTAccessToken new];
      token.accessToken = accessTokenString;
      token.expiresIn = accessTokenExpiresIn;
      
      self.token = token;
    }
  }
  return self;
}

- (RACSignal * _Nonnull)authorize:(NSString * _Nonnull)pinCode {
  NTLogDebug(@"retrieving access token");
  
  @weakify(self)
  
  if (self.token) {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      // do not need to re-authorize
      [subscriber sendNext:self.token];
      
      return [RACDisposable disposableWithBlock:^{
        
      }];
    }];
  } else {
    NTAuthRequestParameters * parameters = [NTAuthRequestParameters new];
    parameters.clientId = self.clientId;
    parameters.clientSecret = self.clientSecret;
    parameters.code = pinCode;

    return [[[self.restClient restSignalWithHTTPMethod:HTTPMethodPOST URLString:NTEndpointAuth parameters:[parameters toDictionary]] map:^id (id value) {
      NSError * error;
      NTAccessToken * token = [[NTAccessToken alloc] initWithDictionary:value error:&error];
      return token;
    }] doNext:^(id response) {
      @strongify(self)
      if (response) {
        [self saveAccessToken:response];
      }
    }];
  }
}

- (BOOL)isSessionValid {
  //TODO: Check expiration time
  return self.token;
}

/// Saves access token properties into the Keychain

- (void)saveAccessToken:(NTAccessToken *)token {
  if (!token) {
    return;
  }
  
  self.token = token;
  
  [NTKeychainStorage setAccessToken:token.accessToken];
  [NTKeychainStorage setAccessTokenExpiresIn:token.expiresIn];
}

- (void)resetAccessToken {
  self.token = nil;
  
  [NTKeychainStorage resetAccessToken];
}

#pragma mark- NTBaseServiceProtocol

- (NSURL *)baseURL {
  return [NSURL URLWithString:[NSString stringWithFormat:@"https://api.%@", NTDomain]];
}
@end
