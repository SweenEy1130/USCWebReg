//
//  MonthCalendar.h
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@protocol MonthCalendarDelegate <NSObject>

- (void)didTappedOnWeek:(NSInteger)week month:(NSInteger)month forYear:(NSInteger)year;
- (void)didTappedOnEvent:(Event *)event;

@end

@interface MonthCalendar : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, assign) id<MonthCalendarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame year:(NSInteger)year month:(NSInteger)month events:(NSArray *)events;

@end
