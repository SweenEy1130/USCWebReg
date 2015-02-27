//
//  CalTableViewCell.m
//  USCholar
//
//  Created by Zheng on 15/2/27.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CalTableViewCell.h"

@implementation CalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    float h = self.textLabel.frame.size.height;
    float ho = self.textLabel.frame.origin.y;
    float w = self.frame.size.width;
    float l = 10;
    float detailWidth = 80;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = CGRectMake(15-l/2.0, ho + h/2.0 + l/2.0 , l, l);
    
    self.detailTextLabel.frame = CGRectMake(w - detailWidth, self.textLabel.frame.origin.y, detailWidth, self.frame.size.height);
    self.detailTextLabel.textColor = [UIColor grayColor];
    
    self.textLabel.frame = CGRectMake(30, self.textLabel.frame.origin.y, self.frame.size.width - 30 - detailWidth, self.frame.size.height);
    [self.textLabel setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
    
    self.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
    
    //self.textLabel.backgroundColor =  [UIColor greenColor];
    //self.backgroundColor = [UIColor grayColor];
    NSLog(@"%f, %f, %f", self.frame.origin.y, h, h/2.0+l/2.0);
}

@end
