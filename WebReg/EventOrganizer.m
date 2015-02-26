//
//  EventOrganizer.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "EventOrganizer.h"
#import "Event.h"

@interface EventOrganizer ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation EventOrganizer

- (id)initWithEvents:(NSArray *)events {
    if(self = [super init]) {
        self.events = events;
    }
    return self;
}

- (NSDictionary *)arrangeInWeeks {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDictionary *weeksDictionary = @{@"week1" : [[NSMutableArray alloc] init],
                                      @"week2" : [[NSMutableArray alloc] init],
                                      @"week3" : [[NSMutableArray alloc] init],
                                      @"week4" : [[NSMutableArray alloc] init]};
    
    for (Event *event in self.events) {
        NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth) fromDate:event.date];
        NSMutableArray *eventArray = [weeksDictionary objectForKey:[NSString stringWithFormat:@"week%ld", comp.weekOfMonth]];
        [eventArray addObject:event];
    }
    
    return weeksDictionary;
}


- (NSDictionary *)arrangeInWeekDays {
    NSMutableDictionary *weekInDays = [[NSMutableDictionary alloc] init];
    NSDictionary *weeks = [self arrangeInWeeks];
    for (id key in weeks) {
        NSArray *weekEvents = [weeks objectForKey:key];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDictionary *dayOfWeekDictionary = @{@"1" : [[NSMutableArray alloc] init],
                                              @"2" : [[NSMutableArray alloc] init],
                                              @"3" : [[NSMutableArray alloc] init],
                                              @"4" : [[NSMutableArray alloc] init],
                                              @"5" : [[NSMutableArray alloc] init],
                                              @"6" : [[NSMutableArray alloc] init],
                                              @"7" : [[NSMutableArray alloc] init]};
        for (Event *event in weekEvents) {
            NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday) fromDate:event.date];
            NSMutableArray *eventArray = [dayOfWeekDictionary objectForKey:[NSString stringWithFormat:@"%ld", comp.weekday]];
            [eventArray addObject:event];
        }
        
        [weekInDays setValue:dayOfWeekDictionary forKey:key];
    }
    return weekInDays;
}

@end
