//
//  WeeklyViewController.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "WeeklyViewController.h"
#import "Event.h"


@interface WeeklyViewController ()

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSArray *eventsForDate;

@end

@implementation WeeklyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendar = [JTCalendar new];
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    self.calendar.calendarAppearance.isWeekMode = YES;
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor blueColor];
    [self.calendar reloadAppearance];
    
    self.events = [[NSMutableArray alloc] init];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:2];
    [dateComponents setYear:2015];
    
    Event *myEvent;
    
    for(int i = 2; i <= 28; i++) {
        [dateComponents setDay:i];
        myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents]];
        myEvent.title = @"A sample title";
        [self.events addObject:myEvent];
        i += [self randomNumberBetween:1 maxNumber:5];
    }
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random_uniform(max - min + 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

#pragma mark - Data Source

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    for (Event *event in self.events) {
        if([event.date compare:date] == NSOrderedSame) {
            return YES; // O(n^2)... but demo...
        }
    }
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"(date == %@)", date];
    self.eventsForDate = [self.events filteredArrayUsingPredicate:filter];
    if(self.eventsForDate.count > 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Event *event = [self.eventsForDate objectAtIndex:indexPath.row];
    [[[UIAlertView alloc] initWithTitle:@"Tapped Event"
                               message:event.title
                              delegate:nil
                     cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventsForDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StateCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Event *event = [self.eventsForDate objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title;
    return cell;
}

@end
