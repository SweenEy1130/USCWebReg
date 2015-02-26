//
//  MonthCalendar.m
//  CalendarWeekly
//
//  Created by Pablo Ochoa on 2/24/15.
//  Copyright (c) 2015 Pablo Ochoa. All rights reserved.
//

#import "MonthCalendar.h"
#import "EventOrganizer.h"
#import "Event.h"

@interface MonthCalendar (){
    EventOrganizer *organizer;
    NSMutableArray *weekViews;
}

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, strong) NSArray *events;


@end

@implementation MonthCalendar

- (id)initWithFrame:(CGRect)frame year:(NSInteger)year month:(NSInteger)month events:(NSArray *)events {

    self = [super initWithFrame:frame];
    if(self) {
        self.year = year;
        self.month = month;
        self.events = events;
        weekViews = [[NSMutableArray alloc] init];
        organizer = [[EventOrganizer alloc] initWithEvents:self.events];
    
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(10, 10);
        self.layer.shadowOpacity = 0.4;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2.0;
    
        NSString *monthName = [[[NSDateFormatter alloc] init] monthSymbols][self.month-1];
        UILabel *lblMonthName = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 100, 2, 144, 22)];
        lblMonthName.backgroundColor = [UIColor clearColor];
        lblMonthName.alpha = 1.0;
        lblMonthName.tag = 1999;
        lblMonthName.textAlignment = NSTextAlignmentCenter;
        lblMonthName.textColor = [UIColor blackColor];
        lblMonthName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0];
        lblMonthName.text = monthName;
        [self addSubview:lblMonthName];
        
    
        [self createWeeks];
        [self createWeekItems];
    }
    return self;
}

- (void)createWeeks {
    
    int weekSize = (self.frame.size.width - 40) / 2; //10 each side and 20 between tiles
    int originX = 10;
    int originY = 30;
    
    for (int i = 1; i <= 4; i++) {
        UIView *week = [[UIView alloc] initWithFrame:CGRectMake(originX, originY, weekSize, weekSize)];
        week.layer.masksToBounds = NO;
        week.layer.shadowColor = [UIColor blackColor].CGColor;
        week.layer.shadowOffset = CGSizeMake(10, 10);
        week.layer.shadowOpacity = 0.4;
        week.backgroundColor = [UIColor whiteColor];
        week.layer.cornerRadius = 5.0;
        week.layer.borderColor = [UIColor blackColor].CGColor;
        week.layer.borderWidth = 2.0;
        [weekViews addObject:week];
        [self addSubview:week];
        
        originX += weekSize + 20;
        if( i%2 == 0) {
            originX = 10;
            originY += weekSize + 10;
        }
    }
}

- (void)createWeekItems {
    int weekNumber = 0;
    NSDictionary *events = [organizer arrangeInWeekDays];
    
    for (UIView *view in weekViews) {
        int x=0;
        int y=25;
        weekNumber += 1;
        int dayOfWeek = 2; //Sunday is 1 in NSCalendar
        NSDictionary *weekEvents = [events objectForKey:[NSString stringWithFormat:@"week%d", weekNumber]];
        
        UILabel *lblWeekName = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 144, 22)];
        lblWeekName.backgroundColor = [UIColor clearColor];
        lblWeekName.alpha = 1.0;
        lblWeekName.userInteractionEnabled = YES;
        lblWeekName.textAlignment = NSTextAlignmentCenter;
        lblWeekName.textColor = [UIColor blackColor];
        lblWeekName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.0];
        lblWeekName.text = [NSString stringWithFormat:@"Week %d", weekNumber];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblWeekTapped:)];
        singleTap.numberOfTapsRequired = 1;
        [lblWeekName addGestureRecognizer:singleTap];
        singleTap.view.tag = weekNumber;
        
        [view addSubview:lblWeekName];
        
        
        NSMutableArray *dailyEvents;
        //40 hard coded items, 8 each 5 days of the week(row)
        for (int d=0; d<25;d++)
        {
            if (d%5 == 0) {
                x += 20;
                y = 25;
                dailyEvents = [[NSMutableArray alloc] initWithArray:[weekEvents objectForKey:[NSString stringWithFormat:@"%d", dayOfWeek]]];
                dayOfWeek += 1;
            } else {
                y += 20;
            }
            
            if(dailyEvents.count > 0) {
                Event *event = [dailyEvents objectAtIndex:0];
                [dailyEvents removeObjectAtIndex:0];
                
                UILabel *lblForDate=[[UILabel alloc]initWithFrame:CGRectMake(x, y, 18, 18)];
                lblForDate.text=[NSString stringWithFormat:@"%d",d];
                lblForDate.textColor = [UIColor blackColor];
                lblForDate.alpha = 1.0;
                lblForDate.userInteractionEnabled = YES;
                lblForDate.tag = d+2000;
                lblForDate.minimumScaleFactor = 0.2;
                lblForDate.adjustsFontSizeToFitWidth = YES;
                lblForDate.textAlignment = NSTextAlignmentCenter;
                lblForDate.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:10.0];
                
                lblForDate.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:156.0/255.0 blue:120.0/255.0 alpha:1.0];
                lblForDate.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:10.0];
                lblForDate.layer.cornerRadius = 9.0;
                lblForDate.clipsToBounds = YES;
                lblForDate.layer.borderWidth = 1.0;
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblDateTapped:)];
                singleTap.numberOfTapsRequired = 1;
                [lblForDate addGestureRecognizer:singleTap];
                singleTap.view.tag = [self.events indexOfObject:event];
                
                [view addSubview:lblForDate];
                
            }
        }
    }
}


#pragma mark - Tapping Date
-(void)lblDateTapped:(UITapGestureRecognizer *)tap//called when any date will be tapped
{
    NSLog(@"tap %ld",(long)tap.view.tag);
    Event *event = [self.events objectAtIndex:tap.view.tag];
    [self.delegate didTappedOnEvent:event];

}

- (void)lblWeekTapped:(UITapGestureRecognizer *)tap
{
    NSLog(@"tap %ld",(long)tap.view.tag);
    NSInteger week = tap.view.tag;
    [self.delegate didTappedOnWeek:week month:self.month forYear:self.year];
}

@end
