//
//  RootViewModel.m
//  Fourtress
//
//  Created by Nail Galiaskarov on 12/12/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "RootViewModel.h"

@import NestSDK;
@import ObjectiveC;

@interface RootViewModel()

@property (readwrite, assign) BOOL loggedIn;

@end

@implementation RootViewModel

- (instancetype)init
{
  self = [super init];
  if (self) {
    @weakify(self)
    [RACObserve([NTAuthorizationService sharedService], token) subscribeNext:^(id  _Nullable token) {
      @strongify(self)
      self.loggedIn = token != nil;
    }];
  }
  return self;
}

@end
