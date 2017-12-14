//
//  NTQueryStringPair.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTQueryStringPair.h"

@implementation NTQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  self.field = field;
  self.value = value;
  
  return self;
}

- (NSString *)URLEncodedStringValue {
  NSCharacterSet * allowedCharacterSet = [NSCharacterSet URLQueryAllowedCharacterSet];

  if (!self.value || [self.value isEqual:[NSNull null]]) {
    return [[self.field description] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
  } else {
    return [NSString stringWithFormat:@"%@=%@", [[self.field description] stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacterSet], [[self.value description] stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacterSet]];
  }
}




@end
