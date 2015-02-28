//
//  WeeklyViewController.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "WeeklyViewController.h"
#import "CalTableViewCell.h"
#import "Event.h"


@interface WeeklyViewController ()

@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSArray *eventsForDate;

@property (nonatomic, strong) UIBarButtonItem *modeItem;
@property (nonatomic, strong) UIBarButtonItem *todayItem;


@end

@implementation WeeklyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _todayItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:self action:@selector(didGoTodayTouch)];
    _modeItem = [[UIBarButtonItem alloc] initWithTitle:@"Week" style:UIBarButtonItemStylePlain target:self action:@selector(didChangeModeTouch)];
    
    self.navigationItem.leftBarButtonItem = _modeItem;
    self.navigationItem.rightBarButtonItem = _todayItem;
    
    // No separator for empty table cells.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.calendar = [JTCalendar new];
   
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    self.calendar.calendarAppearance.isWeekMode = NO;
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Monday
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    // USC red
    // self.calendar.calendarAppearance.dayCircleColorSelected =[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0];
    self.calendar.calendarAppearance.dayDotColor = [UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0];
    [self.calendar reloadAppearance];
    
    _events = [[NSMutableArray alloc] init];
    [self reloadEvents];
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
- (void)reloadEvents{
    [_events removeAllObjects];
    // Hardcore Events
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    // [dateComponents setMonth:2];
    [dateComponents setYear:2015];
    
    Event *myEvent;
    for(int i = 2; i <= 18; i++) {
        [dateComponents setWeekOfYear:i];
        for (int j = 3; j <=5; j+=2){
            [dateComponents setWeekday:j];
            myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents] withTitle:@"CSCI-561" withTime:@"17:00-18:20" withCategory:1];
            [_events addObject:myEvent];
            
            myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents] withTitle:@"CSCI-571" withTime:@"19:00-20:20" withCategory:2];
            [_events addObject:myEvent];
        }
        
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"course"] != nil){
            [dateComponents setWeekday:2];
            myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents] withTitle:@"CSCI-555" withTime:@"14:00-16:50" withCategory:3];
            [_events addObject:myEvent];
        }
        
    }
    
    [dateComponents setMonth:3];
    [dateComponents setYear:2015];
    [dateComponents setDay:2];
    myEvent = [[Event alloc] initWithDate:[[NSCalendar currentCalendar] dateFromComponents:dateComponents] withTitle:@"CSCI-555 Lab 4" withTime:@"23:59" withCategory:2];
    [_events addObject:myEvent];
}
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    for (Event *event in _events) {
        if([event.date compare:date] == NSOrderedSame) {
            return YES; // O(n^2)... but demo...
        }
    }
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"(date == %@)", date];
    _eventsForDate = [_events filteredArrayUsingPredicate:filter];
    
    [self.calendar setCurrentDate:date];
    
    if ([_modeItem.title isEqualToString:@"Week"])
        [self didChangeModeTouch];

    [self.tableView reloadData];
    // NSLog(@"%@", date);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    Event *event = [_eventsForDate objectAtIndex:indexPath.row];
//    [[[UIAlertView alloc] initWithTitle:@"Tapped Event"
//                               message:event.title
//                              delegate:nil
//                     cancelButtonTitle:@"OK"
//                      otherButtonTitles:nil, nil] show];
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_eventsForDate count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StateCell";
    CalTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CalTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"%d %d", indexPath.row, [_eventsForDate count]);
    if ([_eventsForDate count] == 0)
        return;
    Event *event = [_eventsForDate objectAtIndex:indexPath.row];
    
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = event.time;
    
    NSLog(@"%d", event.category);
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dot@%d.png", event.category]]];
    
    // [cell.textLabel setText: @"Introduction to Aritifical intellegence"];
    // [cell.detailTextLabel setText: @"17:00 - 18:20"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}


#pragma mark - Navigation bar trigger
- (void)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
    // NSLog(@"Touch today");
}

- (void)didChangeModeTouch
{
    if ([_modeItem.title isEqualToString:@"Month"]){
        [_modeItem setTitle:@"Week"];
    }else{
        [_modeItem setTitle:@"Month"];
    }
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    // NSLog(@"Touch change view");
    [self transitionExample];
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

@end
