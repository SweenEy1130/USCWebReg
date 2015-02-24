//
//  TFTableViewCell.m
//  WebReg
//
//  Created by ZhengLi on 15/2/23.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "TFTableViewCell.h"

@implementation TFTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.layer setCornerRadius:2.0f];
    [self.layer setMasksToBounds:YES];
    [self.textLabel setTextColor:[UIColor colorWithRed:53.0/255.0 green:49/255.0 blue:49/255.0 alpha:1.0]];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // Makes imageView get placed in the corner
    // self.imageView.frame = CGRectMake( 8, 7.5, 30, 30 );
    // NSLog(@"%f %f", self.textLabel.frame.origin.x, self.textLabel.frame.size.height);
    // self.textLabel.frame = CGRectMake(46, 0, self.frame.size.width - 46, self.frame.size.height);
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.size.width -= 2 * 5;
    frame.origin.y += 2;
    frame.size.height -= 2;
    [super setFrame:frame];
}

@end
