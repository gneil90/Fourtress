//
//  HTTPStatusCode.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#ifndef HTTPStatusCode_h
#define HTTPStatusCode_h

typedef NS_ENUM(NSUInteger, HTTPStatusCode) {
  HTTPStatusCodeOK = 200,
  HTTPStatusCodeMultipleChoices = 300,
  HTTPStatusCodeTemporaryRedirect = 307,
  HTTPStatusCodeUnAuth = 401
};


#endif /* HTTPStatusCode_h */
