//
//  NTDeviceApiService.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTDeviceApiService.h"
#import "NTAuthorizationService.h"
#import "NTConstants.h"
#import "NTRestClient+NestMethods.h"
#import "NSManagedObject+NestMethods.h"
#import "NTThermostatRequestParameters.h"

@import ReactiveObjC;
@import MagicalRecord;

@implementation NTDeviceApiService

+ (instancetype)sharedService {
  static dispatch_once_t once;
  static NTDeviceApiService *instance;
  
  dispatch_once(&once, ^{
    instance = [[NTDeviceApiService alloc] init];
  });
  
  return instance;
}

- (instancetype)init {
  self = [super init];
  if (self) {

    @weakify(self)
    [[RACObserve([NTAuthorizationService sharedService], token) ignore:nil] subscribeNext:^(id token) {
      @strongify(self)
      NSString * accessToken = [NTAuthorizationService sharedService].token.accessToken;
      [self.restClient.requestSerializer setAuthorizationHeaderFieldWithToken:accessToken];
    }];
  }
  return self;
}

- (RACSignal * _Nonnull)fetchThermostat:(NSString * _Nonnull)thermostatId {
  NTLogDebug(@"retrieving thermostat");
  
  NSString * urlString = [NSString stringWithFormat:@"%@/%@", NTEndpointThermostat, thermostatId];
  return [[self.restClient restSignalWithHTTPMethod:HTTPMethodGET URLString:urlString parameters:nil] map:^id _Nullable(id  _Nullable value) {
    if ([value isKindOfClass:[NSDictionary class]]) {
      return [NTThermostat MR_importFromObject:value];
    } else {
      return nil;
    }
  }];
}

- (RACSignal * _Nonnull)setTargetTemperature:(NSInteger)targetTemp forThermostat:(NSString *)thermostatId {
  NTLogDebug(@"Set target temperature %ld for thermostat %@", (long)targetTemp, thermostatId);
  
  NTThermostatRequestParameters * parameters = [NTThermostatRequestParameters new];
  parameters.targetTemperatureC = @(targetTemp);
  
  NSString * urlString = [NSString stringWithFormat:@"%@/%@", NTEndpointThermostat, thermostatId];
  return [self.restClient restSignalWithHTTPMethod:HTTPMethodPUT URLString:urlString parameters:[parameters toDictionary]];
}

- (RACSignal * _Nonnull)fetchStructures {
  NTLogDebug(@"retrieving structure");
  
  return [[self.restClient restSignalWithHTTPMethod:HTTPMethodGET URLString:NTEndpointStructure parameters:nil] map:^id _Nullable(id  _Nullable value) {
    if ([value isKindOfClass:[NSDictionary class]]) {
      return [NTStructure importFromArray:[value allValues]];
    } else {
      return nil;
    }
  }];
}



#pragma mark- NTBaseService Protocol

- (NSURL *)baseURL {
  NSString * baseURLString = [NSString stringWithFormat: @"https://%@", NTDomainAPIDeveloper];
  return [NSURL URLWithString:baseURLString];
}


@end
