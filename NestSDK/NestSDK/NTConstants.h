//
//  NTConstants.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
`NTErrorCode` enum specifies NestSDK error codes
 */
typedef NS_ENUM(NSInteger, NTErrorCode) {
  NTErrorCodeAuthorization = -2000
};

/**
 `NTLogLevel` enum specifies different levels of logging that could be used to limit or display more messages in logs.
 */
typedef NS_ENUM(uint8_t, NTLogLevel) {
  /**
   Log level that disables all logging.
   */
  NTLogLevelNone = 0,
  /**
   Log level that if set is going to output error messages to the log.
   */
  NTLogLevelError = 1,
  /**
   Log level that if set is going to output the following messages to log:
   - Errors
   - Warnings
   */
  NTLogLevelWarning = 2,
  /**
   Log level that if set is going to output the following messages to log:
   - Errors
   - Warnings
   - Informational messages
   */
  NTLogLevelInfo = 3,
  /**
   Log level that if set is going to output the following messages to log:
   - Errors
   - Warnings
   - Informational messages
   - Debug messages
   */
  NTLogLevelDebug = 4
};

// MARK: HTTP


extern NSString * const HTTPMethodPOST;
extern NSString * const HTTPMethodPUT;
extern NSString * const HTTPMethodGET;
extern NSString * const HTTPMethodHEAD;
extern NSString * const HTTPMethodDELETE;

extern NSString * const HTTPContentTypeJSON;
extern NSString * const HTTPContentTypeWWWFormUrlencoded;
extern NSString * const HTTPHeaderContentType;
extern NSString * const HTTPHeaderContentLength;
extern NSString * const HTTPHeaderAcceptLanguage;
extern NSString * const HTTPHeaderAuthorization;
extern NSString * const HTTPHeaderUserAgent;

extern NSString * const NTDomain;
extern NSString * const NTDomainAPIDeveloper;

extern NSString * const NTEndpointAuth;
extern NSString * const NTEndpointStructure;
extern NSString * const NTEndpointThermostat;

//MARK: Thermostat

extern NSInteger const NTThermostatTempMaxC;
extern NSInteger const NTThermostatTempMinC;

