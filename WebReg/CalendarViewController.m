//
//  CalendarViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CalendarViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "Event.h"
#import "WeeklyViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Calendar";
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self rdv_tabBarItem] setBadgeValue:@"3"];
    
    NVCalendar  *vwCal = [[NVCalendar alloc] initWithFrame:self.view.bounds dataSource:self];
    vwCal.monthDelegate = self;
    [self.view addSubview:vwCal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Fake Data

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random_uniform(max - min + 1);
}

#pragma mark - NVCalendarDataSource

- (NSArray *)eventsForYear:(NSInteger)year month:(NSInteger)month {
    // Create a bunch of events for the month
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:2];
    [dateComponents setYear:2015];
    Event *myEvent;
    
    for(int i = 2; i <= 28; i++) {
        [dateComponents setDay:i];
        myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents] withTitle:@"A simple title" withTime:@"17:00-18:00"];

        [events addObject:myEvent];
        i += [self randomNumberBetween:1 maxNumber:5];
    }
    
    return events;
}

#pragma mark - NVCalendarDelegate
- (void)calendarDidTappedOnEvent:(Event *)event {
    //trigger single page for event
    
    [[[UIAlertView alloc] initWithTitle:@"Event Tapped"
                                message:[NSString stringWithFormat:@"%@", event]
                               delegate:nil
                      cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

- (void)calendarDidTappedOnWeek:(NSInteger)week month:(NSInteger)month year:(NSInteger)year {
    //trigger week view for month
    [[[UIAlertView alloc] initWithTitle:@"Week Tapped"
                                message:[NSString stringWithFormat:@"Week %d of month %d of year %d", week, month, year]
                               delegate:nil
                      cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    
    //Show weekly calendar
    WeeklyViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeeklyViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
