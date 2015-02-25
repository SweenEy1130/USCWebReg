//
//  DetailViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "DetailViewController.h"
#import "RDVTabBarController.h"
#import "CourseDetailHeader.h"
#import "CourseSectionDetail.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize _courseCode;
@synthesize _courseID;
@synthesize _termCode;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self._courseCode;
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    
    _scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 75)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview: _scrollView];
    
    NSString * url = [[NSString alloc] initWithFormat:@"http://petri.esd.usc.edu/socAPI/Courses/%ld/%ld", (long)_termCode, (long)_courseID];
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
    if (statusCode != 200) {
        NSLog(@"%s: sendAsynchronousRequest status code != 200: response = %@", __FUNCTION__, response);
        return;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    float layoutHeightOffest = 200;
    float layoutWidthMargin = 10;
    NSError *jsonParsingError = nil;
    NSMutableDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
        return;
    }
    
    NSString *description = JSONData[@"DESCRIPTION"];
    NSString *title = JSONData[@"TITLE"];
    NSString *unit;
    float min_unit = [JSONData[@"MIN_UNITS"] floatValue];
    float max_unit = [JSONData[@"MAX_UNITS"] floatValue];
 
    if (min_unit == max_unit)
    {
        unit = [[NSString alloc] initWithFormat:@"%.f Units", min_unit];
    }else{
        unit = [[NSString alloc] initWithFormat:@"%.f~%.f Units", min_unit, max_unit];
    }
    
    CourseDetailHeader *header = [[CourseDetailHeader alloc]initWithFrame:CGRectMake(layoutWidthMargin, 0, self.view.frame.size.width - layoutWidthMargin * 2, layoutHeightOffest) withTitle:title withUnit: unit withDescription: description];
    [_scrollView addSubview:header];
    layoutHeightOffest = header.frame.size.height;
    
    for (NSDictionary *section in [JSONData objectForKey:@"V_SOC_SECTION"]) {
        NSString * sessionid = [[NSString alloc] initWithFormat:@"Section %@", section[@"SECTION"]];
        NSString * type;
        NSString * capacity;
        
        if ([section[@"TYPE"] isKindOfClass:[NSNull class]]){
            type = @"N/A";
        }else{
            type = section[@"TYPE"];
        }
        if ([section[@"REGISTERED"] isKindOfClass:[NSNull class]]){
            capacity = [[NSString alloc] initWithFormat:@"0/%ld", (long)[section[@"SEATS"] intValue]];
        }else{
            capacity = [[NSString alloc] initWithFormat:@"%ld/%ld", (long)[section[@"REGISTERED"] intValue], (long)[section[@"SEATS"] intValue]];
        }
        NSString * location;
        if ([section[@"LOCATION"] isKindOfClass:[NSNull class]]){
            location = @"N/A"; //[[NSString alloc] initWithFormat:@"N/A"];
        }else{
            location = [[NSString alloc] initWithFormat:@"%@", section[@"LOCATION"]];
        }
        
        NSString *time;
        if ([section[@"DAY"] isKindOfClass:[NSNull class]]){
            time = [[NSString alloc] initWithFormat:@"N/A"];
        }else{
            time = [[NSString alloc] initWithFormat:@"%@ %@-%@", section[@"DAY"], section[@"BEGIN_TIME"], section[@"END_TIME"]];
        }
        
        NSString *instructor;
        if ([section[@"INSTRUCTOR"] isKindOfClass:[NSNull class]]){
            instructor = [[NSString alloc] initWithFormat:@"N/A"];
        }else{
            instructor = [[NSString alloc] initWithFormat:@"%@", section[@"INSTRUCTOR"]];
        }
        
        NSString *info = [[NSString alloc] initWithFormat:@"%@\n%@\n%@\n%@\n%@", type, capacity, location, time, instructor];
        
        CourseSectionDetail* sectionDetail = [[CourseSectionDetail alloc] initWithFrame:CGRectMake(layoutWidthMargin, 10 + layoutHeightOffest, self.view.frame.size.width - layoutWidthMargin*2, 140) withTitle:sessionid withInfo:info];
        [_scrollView  addSubview:sectionDetail];
        layoutHeightOffest += 5 + sectionDetail.bounds.size.height;
    }
    [_scrollView setContentSize: CGSizeMake(self.view.frame.size.width, layoutHeightOffest)];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
