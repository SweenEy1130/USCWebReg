#import "NVCalendar.h"
#import "Event.h"
#import "EventOrganizer.h"
#import "MonthCalendar.h"
#import "UIDevice+Resolutions.h"

@interface NVCalendar () {
    int weekSize;
    NSMutableArray *weeks;
    EventOrganizer *eventOrganizer;
}

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) NSDictionary *events;

@end

@implementation NVCalendar

- (id)initWithFrame:(CGRect)frame dataSource:(id<NVCalendarDataSource>)dataSource; {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241.0/255.0
                                               green:241.0/255.0
                                                blue:241.0/255.0
                                               alpha:1.0];
        CGRect frame = [self getDeviceFrame];
        CGSize contentSize = CGSizeMake(frame.size.width, frame.size.height);
        
        for (int i = 1; i <= 12; i ++) { // Hardcoded year
            
            NSArray *events = [dataSource eventsForYear:2015 month:i];
            
            MonthCalendar *monthCalendar = [[MonthCalendar alloc] initWithFrame:frame
                                                                          year:2015
                                                                          month:i
                                                                         events:events];
            monthCalendar.delegate = self;
            [self addSubview:monthCalendar];
            
            frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height + 20, frame.size.width, frame.size.height);
            contentSize = CGSizeMake(contentSize.width, contentSize.height + frame.size.height + 20);
        }
        
        [self setContentSize:contentSize];
        
    }
    return self;
}

- (CGRect)getDeviceFrame {
     CGRect frame = CGRectMake(20, 40, 320, 340);
    if ([UIDevice isPhone5]) {
        frame = CGRectMake(20, 40, 280, 300);
    }
    return frame;
}

#pragma mark - Month Calendar Delegate

- (void)didTappedOnEvent:(Event *)event {
    [self.monthDelegate calendarDidTappedOnEvent:event];
}

- (void)didTappedOnWeek:(NSInteger)week month:(NSInteger)month forYear:(NSInteger)year {
    [self.monthDelegate calendarDidTappedOnWeek:week month:month year:year];
}


@end
