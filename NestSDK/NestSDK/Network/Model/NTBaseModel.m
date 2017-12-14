//
//  NTBaseModel.m
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTBaseModel.h"

@implementation NTBaseModel

/**
 * Overwrite in model if property names don't match JSON key names.
 * Lookup JSONKeyMapper docs for more details.
 */

+ (JSONKeyMapper *)keyMapper {
  return [JSONKeyMapper mapperForSnakeCase];
}

@end
