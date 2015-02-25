//
//  EventOrganizer.h
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//  Class designed to split monthly events in weeks

#import <Foundation/Foundation.h>

@interface EventOrganizer : NSObject

- (id)initWithEvents:(NSArray *)events;

- (NSDictionary *)arrangeInWeeks;
- (NSDictionary *)arrangeInWeekDays;

@end
