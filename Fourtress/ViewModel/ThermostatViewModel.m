//
//  ThermostatViewModel.m
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "ThermostatViewModel.h"

@import NestSDK;

@interface ThermostatViewModel() <NTBasePollServiceDelegate>

@property (strong, nonatomic) NTBasePollService * pollService;

@end

@implementation ThermostatViewModel

- (instancetype)init {
  self = [super init];
  if (self) {
    self.pollService = [NTBasePollService new];
    self.pollService.delegate = self;
    
    // retrieve latest cached thermostat
    self.thermostat = [NTThermostat findFirst];
    
    @weakify(self)
    [RACObserve([NTAuthorizationService sharedService], token) subscribeNext:^(id  _Nullable token) {
      @strongify(self)
      if (token != nil) {
        [self.pollService startPollTimer];
      } else {
        [self.pollService stopPollTimer];
      }
    }];
  }
  return self;
}

#pragma NTBasePollServiceDelegate

- (void)triggerPollingOperation {
  self.isRefreshing = YES;
  RACSignal * fetchThermostatSignal;
  if (!self.thermostat) {
    RACSignal * mergedSignal = [[self fetchStructureSignal] flattenMap:^__kindof RACSignal * _Nullable(NSArray * _Nullable structures) {
      // Just for demo purposes show the first thermostat available
      NTStructure * structure = [structures firstObject];
      NTThermostat * thermostat = [[structure.thermostats allObjects] firstObject];
      
      self.thermostat = thermostat;
      
      return [self fetchThermostatSignal];
    }];
    
    fetchThermostatSignal = mergedSignal;
  } else {
    fetchThermostatSignal = [self fetchThermostatSignal];
  }
  
  [fetchThermostatSignal subscribeNext:^(id  _Nullable x) {
    //Update ViewModel with latest thermostat
    self.isRefreshing = NO;
  } error:^(NSError * _Nullable error) {
    self.isRefreshing = NO;
  }];
}

/// Fetch structure signal, not executed until signal is subscribed
- (RACSignal *)fetchStructureSignal {
  return [[[NTDeviceApiService sharedService] fetchStructures] deliverOnMainThread];
}

/// Fetch thermostat signal, not executed until someone is subscribed
- (RACSignal *)fetchThermostatSignal {
  return [[[NTDeviceApiService sharedService] fetchThermostat:self.thermostat.deviceId] deliverOnMainThread];
}

- (void)dealloc {
  
}

@end
