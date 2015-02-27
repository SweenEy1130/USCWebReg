//
//  Event.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initWithDate:(NSDate *)date withTitle:(NSString *)title withTime:(NSString *)time withCategory:(int)category{
    if(self = [super init]) {
        _date = date;
        _title = title;
        _time = time;
        _category = category;
    }
    return self;
}

@end
