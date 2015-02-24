//
//  CourseSectionDetail.m
//  WebReg
//
//  Created by ZhengLi on 15/2/22.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CourseSectionDetail.h"

@implementation CourseSectionDetail

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
        UITextView *sectionidField = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        [sectionidField setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [sectionidField setText:title];
        [sectionidField setTextColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
        [sectionidField setBackgroundColor:[UIColor clearColor]];
        sectionidField.editable = NO;
        sectionidField.scrollEnabled = NO;
        [sectionidField sizeToFit];
        [sectionidField layoutIfNeeded];
        [self addSubview:sectionidField];
        tHeight += sectionidField.bounds.size.height;
        
        UIImageView *addIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, 8, sectionidField.bounds.size.height-16, sectionidField.bounds.size.height-16)];
        addIcon.image = [UIImage imageNamed:@"icon_plus"];
        addIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:addIcon];
        
        UITextView *infoField;
        UITextView *infoHeaderField;
        infoField = [[UITextView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.4, tHeight, self.bounds.size.width, 30)];
        infoHeaderField = [[UITextView alloc] initWithFrame:CGRectMake(0, tHeight, self.bounds.size.width, 30)];
        
        [infoField setContentInset:UIEdgeInsetsMake(-8,0,0,0)];
        [infoField setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [infoField setText:info];
        [infoField setTextColor:[UIColor colorWithRed:93.0/255.0 green:89/255.0 blue:89/255.0 alpha:1.0]];
        [infoField setBackgroundColor:[UIColor clearColor]];
        infoField.editable = NO;
        infoField.scrollEnabled = NO;
        [infoField sizeToFit];
        [infoField layoutIfNeeded];
        [self addSubview:infoField];
        
        [infoHeaderField setContentInset:UIEdgeInsetsMake(-8,0,0,0)];
        [infoHeaderField setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [infoHeaderField setText:@"Type:\nRegistered:\nLocation:\nTime:\nInstructor"];
        [infoHeaderField setTextColor:[UIColor colorWithRed:93.0/255.0 green:89/255.0 blue:89/255.0 alpha:1.0]];
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

@end
