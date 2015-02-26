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

- (id)initWithDate:(NSDate *)date;

@end
