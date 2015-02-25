//
//  TFTableView.m
//  WebReg
//
//  Created by ZhengLi on 15/2/24.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "TFTableViewController.h"
#import "MCSwipeTableViewCell.h"
#import "DetailViewController.h"

@implementation TFTableViewController{
    NSMutableArray *_courseID;
    NSMutableArray *_courseCode;
    NSMutableArray *_courseTitle;
    int _courseNo;
    NSString * _curTerm;
    NSInteger _curLevelIdx;
    
    UIActivityIndicatorView * activityView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];}
-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor: [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]];
    }
    return self;
}
// Table view
- (NSUInteger)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Table view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", [_courseCode objectAtIndex:indexPath.row],
                               [_courseTitle objectAtIndex: indexPath.row]]];
    
    UIView *crossView = [self viewWithImageName:@"Cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];

    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        // NSLog(@"Did swipe \"Cross\" cell");
        [self deleteCell:cell];
    }];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _courseNo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *viewController = [[DetailViewController alloc] init];
    viewController._courseID = [_courseID[indexPath.row] intValue];
    viewController._termCode = [_curTerm integerValue];
    viewController._courseCode = _courseCode[indexPath.row];
    [self.parentViewController.navigationController pushViewController:viewController animated:YES];
}

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
    [activityView stopAnimating];
    NSError *jsonParsingError = nil;
    NSMutableArray *JSONData = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
        return;
    }
    _courseNo = 0;
    _courseTitle = [[NSMutableArray alloc] init];
    _courseCode = [[NSMutableArray alloc] init];
    _courseID = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dictionary in JSONData)
    {
        NSString *courseid = dictionary[@"SIS_COURSE_ID"];
        int course_level = [[courseid componentsSeparatedByString:@"-"][1] intValue];
        if (_curLevelIdx == 1 && course_level >= 400)
            continue;
        if (_curLevelIdx == 2 && course_level < 400)
            continue;
        
        NSString *arrayString = dictionary[@"TITLE"];
        if (arrayString){
            [_courseTitle addObject:dictionary[@"TITLE"]];
            [_courseCode addObject:dictionary[@"SIS_COURSE_ID"]];
            [_courseID addObject:dictionary[@"COURSE_ID"]];
            _courseNo++;
        }
        
    }
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    // [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void)getCourseList:(NSString *)curTerm withDept:(NSString *)curDept withLevel:(NSInteger)curLevel{
    _curTerm = curTerm;
    NSString * url = [[NSString alloc] initWithFormat:@"http://petri.esd.usc.edu/socAPI/Courses/%@/%@", curTerm, curDept];
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    _curLevelIdx = curLevel;
    
    // Clear previous result
    _courseNo = 0;
    [self.tableView reloadData];
    
    // Add loading indicator
    if (activityView == nil){
        activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
        activityView.color = [UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0];
    }
    [activityView startAnimating];
    [self.view addSubview:activityView];

}

#pragma mark - Utils
- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    _courseNo--;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}


@end
