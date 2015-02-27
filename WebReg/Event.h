//
//  Event.h
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;

- (id)initWithDate:(NSDate *)date withTitle:(NSString *)title withTime:(NSString *)time;

@end
