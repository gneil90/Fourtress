//
//  NTThermostatPollService.h
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NTBasePollServiceDelegate

/// Notifies delegate every `refreshPeriod` seconds to execute operation
- (void)triggerPollingOperation;

@end

@interface NTBasePollService : NSObject

/// Every `refreshPeriod` seconds, poll services initiates a call to update. By default: 15s
@property (assign, nonatomic) NSTimeInterval refreshPeriod;
@property (weak, nonatomic, nullable) id <NTBasePollServiceDelegate> delegate;

/// Start polling every `refreshPeriod` seconds
- (void)startPollTimer;

/*
 Completely stops the timer, so it will not be activated after application became active
 */
- (void)stopPollTimer;

@end
