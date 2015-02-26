//
//  WeeklyViewController.h
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface WeeklyViewController : UIViewController <JTCalendarDataSource, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) JTCalendar *calendar;

@end
