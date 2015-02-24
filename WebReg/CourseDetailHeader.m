//
//  CourseDetailHeader.m
//  WebReg
//
//  Created by ZhengLi on 15/2/22.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CourseDetailHeader.h"
#define MAX_HEIGHT 100

@implementation CourseDetailHeader

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withUnit:(NSString *)unit withDescription:(NSString *)description
{
    self = [super initWithFrame:frame];
    if (self) {
        UITextView *titleField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 50)];
        [titleField setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [titleField setText:title];
        [titleField setTextColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
        [titleField setBackgroundColor:[UIColor clearColor]];
        titleField.editable = NO;
        titleField.scrollEnabled = NO;
        [titleField sizeToFit];
        [titleField layoutIfNeeded];
        [self addSubview:titleField];
        
        UITextView *unitField = [[UITextView alloc] initWithFrame:CGRectMake(0, titleField.frame.size.height, self.bounds.size.width, 25)];
        [unitField setContentInset:UIEdgeInsetsMake(-8,0,0,0)];
        [unitField setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [unitField setText:unit];
        [unitField setTextColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
        [unitField setBackgroundColor:[UIColor clearColor]];
        unitField.editable = NO;
        unitField.scrollEnabled = NO;
        [self addSubview:unitField];
        
        UITextView *descriptionField = [[UITextView alloc] initWithFrame:CGRectMake(0, unitField.bounds.size.height + titleField.bounds.size.height, self.bounds.size.width, 120)];
        // [descriptionField setContentInset:UIEdgeInsetsMake(-8,0,8,0)];
        [descriptionField setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        [descriptionField setText:description];
        [descriptionField setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
        [descriptionField setBackgroundColor:[UIColor clearColor]];
        descriptionField.editable = NO;
        descriptionField.scrollEnabled = NO;
        [descriptionField sizeToFit];
        [descriptionField layoutIfNeeded];
        [self addSubview:descriptionField];
        
        CGRect newframe = frame;
        newframe.size.height = titleField.bounds.size.height + unitField.bounds.size.height + descriptionField.bounds.size.height;
        [self setFrame:newframe];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

@end
