//
//  NTConstant.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTConstants.h"

NSString * const HTTPMethodPOST = @"POST";
NSString * const HTTPMethodPUT = @"PUT";
NSString * const HTTPMethodGET = @"GET";
NSString * const HTTPMethodDELETE = @"DELETE";
NSString * const HTTPMethodHEAD = @"HEAD";

NSString * const HTTPContentTypeJSON = @"application/json";
NSString * const HTTPContentTypeWWWFormUrlencoded = @"application/x-www-form-urlencoded";

NSString * const HTTPHeaderContentType = @"Content-Type";
NSString * const HTTPHeaderContentLength = @"Content-Length";
NSString * const HTTPHeaderAcceptLanguage = @"Accept-Language";
NSString * const HTTPHeaderAuthorization = @"Authorization";
NSString * const HTTPHeaderUserAgent = @"User-Agent";

NSString * const NTDomain = @"home.nest.com";

NSString * const NTDomainAPIDeveloper = @"developer-api.nest.com";

//MARK: Endpoints

NSString * const NTEndpointAuth = @"oauth2/access_token";
NSString * const NTEndpointStructure = @"structures";
NSString * const NTEndpointThermostat = @"devices/thermostats";

//MARK: Thermostat

NSInteger const NTThermostatTempMaxC = 32;
NSInteger const NTThermostatTempMinC = 9;

