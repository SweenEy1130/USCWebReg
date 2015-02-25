#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Event.h"
#import "MonthCalendar.h"

@protocol NVCalendarDataSource

- (NSArray *)eventsForYear:(NSInteger)year month:(NSInteger)month;

@end

@protocol NVCalendarDelegate <NSObject>

- (void)calendarDidTappedOnEvent:(Event*)event;
- (void)calendarDidTappedOnWeek:(NSInteger)week month:(NSInteger)month year:(NSInteger)year;

@end

@interface NVCalendar : UIScrollView <MonthCalendarDelegate> {
}

@property (nonatomic, assign) id<NVCalendarDataSource> dataSource;
@property (nonatomic, assign) id<NVCalendarDelegate> monthDelegate;

- (id)initWithFrame:(CGRect)frame dataSource:(id<NVCalendarDataSource>)dataSource;

@end
