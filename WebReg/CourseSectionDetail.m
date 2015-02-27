//
//  CourseSectionDetail.m
//  WebReg
//
//  Created by ZhengLi on 15/2/22.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CourseSectionDetail.h"

@implementation CourseSectionDetail{
    NSString * courseTitle;
    UIButton * plusBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withInfo:(NSString *)info
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        float tHeight = 0;
        UIColor *red = [UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0];
        UITextView *sectionidField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        [sectionidField setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [sectionidField setText:title];
        [sectionidField setTextColor:red];
        [sectionidField setBackgroundColor:[UIColor clearColor]];
        sectionidField.editable = NO;
        sectionidField.scrollEnabled = NO;
        [sectionidField sizeToFit];
        [sectionidField layoutIfNeeded];
        [self addSubview:sectionidField];
        tHeight += sectionidField.bounds.size.height;
        
        courseTitle = title;
        plusBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        plusBtn.frame = CGRectMake(self.bounds.size.width-35, 8, sectionidField.bounds.size.height-16, sectionidField.bounds.size.height-16);
        UIImage *plusImage = [UIImage imageNamed:@"icon_plus"];
        [plusBtn setImage:plusImage forState:UIControlStateNormal];
        [plusBtn setTintColor:red];
        [self addSubview:plusBtn];
        [plusBtn addTarget:self action:@selector(alertConfirmationDialog) forControlEvents:UIControlEventTouchUpInside];

        
        UITextView *infoField;
        UITextView *infoHeaderField;
        infoField = [[UITextView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.4, tHeight, self.bounds.size.width* 0.6, 30)];
        infoHeaderField = [[UITextView alloc] initWithFrame:CGRectMake(0, tHeight, self.bounds.size.width * 0.4, 30)];
        
        [infoField setContentInset:UIEdgeInsetsMake(-8,0,0,0)];
        [infoField setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [infoField setText:info];
        [infoField setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
        [infoField setBackgroundColor:[UIColor clearColor]];
        infoField.editable = NO;
        infoField.scrollEnabled = NO;
        [infoField sizeToFit];
        [infoField layoutIfNeeded];
        [self addSubview:infoField];
        
        [infoHeaderField setContentInset:UIEdgeInsetsMake(-8,0,0,0)];
        [infoHeaderField setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [infoHeaderField setText:@"Type:\nRegistered:\nLocation:\nTime:\nInstructor"];
        [infoHeaderField setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
        [infoHeaderField setBackgroundColor:[UIColor clearColor]];
        infoHeaderField.editable = NO;
        infoHeaderField.scrollEnabled = NO;
        [infoHeaderField sizeToFit];
        [infoHeaderField layoutIfNeeded];
        [self addSubview:infoHeaderField];
        
        tHeight += infoField.bounds.size.height;
        CGRect newframe = frame;
        newframe.size.height = tHeight;
        [self setFrame:newframe];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)alertConfirmationDialog{
    NSString * info = [NSString stringWithFormat:@"Are you sure to add %@?", courseTitle];
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Confirmation"
                                                     message:info
                                                    delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    if (buttonIndex == 1)
    {
        // NSLog(@"You have clicked Yes");
        [plusBtn setImage:[UIImage imageNamed:@"Check"] forState:UIControlStateNormal];
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
        notification.alertBody = [NSString stringWithFormat: @"%@ has been added!", courseTitle];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    else if(buttonIndex == 0)
    {
        // NSLog(@"You have clicked Cancel");
    }
}

@end
