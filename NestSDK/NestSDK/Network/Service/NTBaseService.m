//
//  NTBaseService.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTBaseService.h"

@interface NTBaseService()

@property (readwrite, nonatomic) NTRestClient * restClient;

@end

@implementation NTBaseService

+ (instancetype)sharedService {
  static dispatch_once_t once;
  static NTBaseService *instance;
  
  dispatch_once(&once, ^{
    instance = [[NTBaseService alloc] init];
  });
  
  return instance;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.restClient = [[NTRestClient alloc] initWithBaseURL:[self baseURL]];
  }
  return self;
}

@end
