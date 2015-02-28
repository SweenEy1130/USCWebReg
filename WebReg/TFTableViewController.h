//
//  TFTableView.h
//  WebReg
//
//  Created by ZhengLi on 15/2/24.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFTableViewController : UITableViewController<NSURLConnectionDelegate>{
    NSMutableData *_responseData;
}

@property (strong, nonatomic) UISearchController * courseSearchController;

- (void)getCourseList:(NSString *)curTerm withDept:(NSString *)curDept withLevel:(NSInteger)curLevel;

@end
