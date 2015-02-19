//
//  CourseViewController.h
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseViewController : UITableViewController<NSURLConnectionDelegate>{
    NSMutableData *_responseData;
}

@end
