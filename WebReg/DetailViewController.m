//
//  DetailViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "DetailViewController.h"
#import "RDVTabBarController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize _courseID;
@synthesize _termCode;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Details";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
    
    NSString * url = [[NSString alloc] initWithFormat:@"http://petri.esd.usc.edu/socAPI/Courses/%ld/%ld", _termCode, _courseID];
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
    NSError *jsonParsingError = nil;
    NSMutableDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
        return;
    }
    
    UILabel *label = [[UILabel alloc] init];
    NSString *arrayString = JSONData[@"DESCRIPTION"];
    if (arrayString){
        label.text = arrayString;
    }
    label.frame = CGRectMake(20, 150, CGRectGetWidth(self.view.frame) - 2 * 20, 20);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
