//
//  DetailViewController.h
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    UIScrollView * _scrollView;
}
@property (nonatomic, assign) NSInteger _courseID;
@property (nonatomic, assign) NSString *_courseCode;
@property (nonatomic, assign) NSInteger _termCode;
@end
