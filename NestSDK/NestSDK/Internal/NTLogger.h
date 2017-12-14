//
//  NTLogger.h
//  NestSDK
//
//  Created by Nail Galiaskarov on 12/11/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTConstants.h"

typedef uint8_t NTLoggingTag;

@interface NTLogger : NSObject

@property (atomic, assign) NTLogLevel logLevel;

#pragma mark - Shared Logger

/**
 A shared instance of `NTLogger` that should be used for all logging.
 */
+ (instancetype)sharedLogger;

/**
 Logs a message at a specific level for a tag.
 If current logging level doesn't include this level - this method does nothing.
 @param format Format to use for the log message.
 */
- (void)logMessageWithLevel:(NTLogLevel)level
                        tag:(NTLoggingTag)tag
                     format:(NSString *)format, ... NS_FORMAT_FUNCTION(3, 4);

@end
