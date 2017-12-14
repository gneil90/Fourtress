//
//  NTThermostatPollService.m
//  NestSDK
//
//  Created by Galiaskarov Nail on 12/10/17.
//  Copyright © 2017 Nest. All rights reserved.
//

#import "NTBasePollService.h"
#import "NTConstants.h"
#import "NTThermostat+CoreDataProperties.h"

@import ReactiveObjC;
@import UIKit.UIApplication;

NSInteger const NTPollServiceDefaultRefreshPeriod = 15;

@interface NTBasePollService()

@property (strong, nonatomic) NSTimer * pollTimer;
@property (assign, nonatomic) BOOL enabled;

@end

@implementation NTBasePollService

- (instancetype)init {
  self = [super init];
  if (self) {
    self.refreshPeriod = NTPollServiceDefaultRefreshPeriod;
    
    // Pause timer when application goes to background
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pausePollTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    // Resume timer if application did become active
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resumePollTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
  }
  return self;
}

/**
 * Set up the polling timer.
 */
- (void)startPollTimer {
  [self poll];
  [self invalidatePollTimer];
  
  // Enable the timer on the main thread and pass the thermostat
  //   as a parameter (userInfo)
  dispatch_async(dispatch_get_main_queue(), ^{
    self.pollTimer = [NSTimer scheduledTimerWithTimeInterval:self.refreshPeriod
                                                      target:self
                                                    selector:@selector(poll)
                                                    userInfo:nil
                                                     repeats:YES];
    self.enabled = true;
  });
}

/// Executes every refresh period seconds
- (void)poll {
  [self.delegate triggerPollingOperation];
}

/*
 Invalidates the timer when application goes to background. Will be resumed when application goes active
 */
- (void)pausePollTimer {
  [self invalidatePollTimer];
}

/*
 Completely stops the timer, so it will not be activated after application became active
 */
- (void)stopPollTimer {
  [self invalidatePollTimer];
  self.enabled = false;
}

/*
 Resumes timer if needed after the application didBecomeActive
 */
- (void)resumePollTimer {
  if (self.enabled) {
    [self startPollTimer];
  }
}

/**
 * Invalidate (turn off) the read polling timer
 */
- (void)invalidatePollTimer {  
  if ([self.pollTimer isValid]) {
    [self.pollTimer invalidate];
    self.pollTimer = nil;
  }
}

- (void)dealloc {
  [self.pollTimer invalidate];
  self.pollTimer = nil;
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
