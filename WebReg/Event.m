//
//  Event.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initWithDate:(NSDate *)date {
    if(self = [super init]) {
        self.date = date;
    }
    return self;
}

@end
