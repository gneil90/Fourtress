//
//  NTLogger.m
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTLogger.h"
#import "NTConstants.h"

@implementation NTLogger

///--------------------------------------
#pragma mark - Class
///--------------------------------------

+ (NSString *)_descriptionForLoggingTag:(NTLoggingTag)tag {
  NSString *description = nil;
  switch (tag) {
    case NTLoggingTagCommon:
      break;
    case NTLoggingTagCrashReporting:
      description = @"Crash Reporting";
      break;
    default:
      break;
  }
  return description;
}

+ (NSString *)_descriptionForLogLevel:(NTLogLevel)logLevel {
  NSString *description = nil;
  switch (logLevel) {
    case NTLogLevelNone:
      break;
    case NTLogLevelDebug:
      description = @"Debug";
      break;
    case NTLogLevelError:
      description = @"Error";
      break;
    case NTLogLevelWarning:
      description = @"Warning";
      break;
    case NTLogLevelInfo:
      description = @"Info";
      break;
  }
  return description;
}

#pragma mark - Init

+ (instancetype)sharedLogger {
  static NTLogger *logger;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    logger = [[NTLogger alloc] init];
  });
  return logger;
}

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  _logLevel = NTLogLevelNone;
  
  return self;
}

///--------------------------------------
#pragma mark - Logging Messages
///--------------------------------------

- (void)logMessageWithLevel:(NTLogLevel)level
                        tag:(NTLoggingTag)tag
                     format:(NSString *)format, ... NS_FORMAT_FUNCTION(3, 4) {
  if (level > self.logLevel || level == NTLogLevelNone || !format) {
    return;
  }
  
  va_list args;
  va_start(args, format);
  
  NSMutableString *message = [NSMutableString stringWithFormat:@"[%@]", [[self class] _descriptionForLogLevel:level]];
  
  NSString *tagDescription = [[self class] _descriptionForLoggingTag:tag];
  if (tagDescription) {
    [message appendFormat:@"[%@]", tagDescription];
  }
  
  [message appendFormat:@": %@", format];
  
  NSLogv(message, args);
  
  va_end(args);
}


@end
