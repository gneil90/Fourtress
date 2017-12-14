//
//  NTLogging.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#ifndef NTLogging_h
#define NTLogging_h

#import "NTLogger.h"

static const NTLoggingTag NTLoggingTagCommon = 0;
static const NTLoggingTag NTLoggingTagCrashReporting = 100;

#define NTLog(level, loggingTag, frmt, ...) \
[[NTLogger sharedLogger] logMessageWithLevel:level tag:loggingTag format:(frmt), ##__VA_ARGS__]

#define NTLogError(tag, frmt, ...) \
NTLog(NTLogLevelError, (tag), (frmt), ##__VA_ARGS__)

#define NTLogWarning(tag, frmt, ...) \
NTLog(NTLogLevelWarning, (tag), (frmt), ##__VA_ARGS__)

#define NTLogInfo(tag, frmt, ...) \
NTLog(NTLogLevelInfo, (tag), (frmt), ##__VA_ARGS__)

#define NTLogDebug(frmt, ...) \
NTLog(NTLogLevelDebug, NTLoggingTagCommon, (frmt), ##__VA_ARGS__)

#define NTLogException(exception) \
NTLogError(NTLoggingTagCommon, @"Caught \"%@\" with reason \"%@\"%@", \
exception.name, exception, \
[exception callStackSymbols] ? [NSString stringWithFormat:@":\n%@.", [exception callStackSymbols]] : @"")


#endif /* NTLogging_h */
