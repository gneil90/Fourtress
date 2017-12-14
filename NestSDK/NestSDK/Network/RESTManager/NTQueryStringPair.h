//
//  NTQueryStringPair.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTQueryStringPair : NSObject

@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

/// Returns a new string made from the "key=value" by replacing all characters not in the allowedCharacters set with percent encoded characters.
- (NSString *)URLEncodedStringValue;

@end
