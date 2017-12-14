//
//  NTAuthRequestParameters.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/13/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTAuthRequestParameters.h"

NSString * const NTGrantTypeAuthorizationCode = @"authorization_code";

@implementation NTAuthRequestParameters

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.grantType = NTGrantTypeAuthorizationCode;
  }
  return self;
}

@end
