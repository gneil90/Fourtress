//
//  NTAuthViewModel.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTAuthViewModel.h"
#import "NTAuthorizationService.h"
#import "NSError+NestMethods.h"
#import "NSString+NestMethods.h"
#import "NTConstants.h"
#import "NTDeviceApiService.h"

@import ReactiveObjC;

@implementation NTAuthViewModel

- (instancetype)init
{
  self = [super init];
  if (self) {
    @weakify(self)
    
    RACSignal * pinCodeSignal = [[RACObserve(self, pinCode) ignore:nil] deliverOn:RACScheduler.mainThreadScheduler];
    
    // Logs in the user, then fetches the structures from the server. After that's all done, lets user to continue using application

    [pinCodeSignal subscribeNext:^(id pinCode) {
      @strongify(self)
      self.isBusy = YES;
      RACSignal * authSignal = [[[NTAuthorizationService sharedService] authorize:self.pinCode] deliverOn:RACScheduler.mainThreadScheduler];
      
      @weakify(self)
      [[authSignal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // Return a signal that loads structures for the user.
        RACSignal * fetchStructureSignal = [[NTDeviceApiService sharedService] fetchStructures];
        return fetchStructureSignal;
      }] subscribeError:^(NSError * _Nullable error) {
        @strongify(self)
        self.isBusy = NO;
        self.error = [NSError errorWithMessage:[@"Please, try again later" localized] code:NTErrorCodeAuthorization];
      } completed:^{
        @strongify(self)
        self.isBusy = NO;
        self.isAuthorized = YES;
      }];
    }];    
  }
  return self;
}

@end
