//
//  LUTimeTableSampleCalendarEvent.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTimeTableCalendarEvent.h"

@interface LUTimeTableSampleCalendarEvent : NSObject <LUTimeTableCalendarEvent>
                                                                                                                                        // randomDurationMinutes:(int)randomDuration
+ (instancetype)randomEvent:(NSString *)title randomDay:(int)randomDay randomHour:(int)randomStartHour randomStartTime:(NSString *)randomStartTime randomEndTime:(NSString *)randomEndTime randomDuration:(int)randomDuration randomDurationMinutes:(int)randomDurationMinutes randomStartDurationMinutes:(int)randomStartDurationMinutes;
                                                                                                                                        //durationInMinutes:(NSInteger)durationInMinutes
+ (instancetype)eventWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour StartTime:(NSString *)StartTime EndTime:(NSString *)EndTime durationInHours:(NSUInteger)durationInHours durationInMinutes:(NSInteger)durationInMinutes durationStartInMinutes:(NSInteger)durationStartInMinutes;

- (instancetype)initWithTitle:(NSString *)title day:(NSUInteger)day startHour:(NSUInteger)startHour StartTime:(NSString *)StartTime EndTime:(NSString *)EndTime durationInHours:(NSUInteger)durationInHours durationInMinutes:(NSInteger)durationInMinutes durationStartInMinutes:(NSInteger)durationStartInMinutes;;

@end
