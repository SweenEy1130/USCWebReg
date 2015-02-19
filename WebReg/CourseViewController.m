//
//  CourseViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "CourseViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "JSDropDownMenu.h"
#import "DetailViewController.h"

@interface CourseViewController () <JSDropDownMenuDataSource, JSDropDownMenuDelegate>{
    NSMutableArray *_schoolName;
    NSMutableArray *_termName;
    NSMutableArray *_levelName;
    NSMutableArray *_termCode;
    
    NSInteger _currentSchoolIndex;
    NSInteger _currentTermIndex;
    NSInteger _currentLevelIndex;
    NSInteger _currentDeptIndex;
    NSString *_currentDeptCode;
    
    NSMutableArray *_courseID;
    NSMutableArray *_courseCode;
    NSMutableArray *_courseTitle;
    int _courseNo;
}

@end

@implementation CourseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Course";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Configure dropdown menu
    NSArray *keck = @[@"ACMD", @"AMED", @"ANST", @"BIOC", @"CBG", @"CNB", @"DSR", @"HP", @"INTD", @"MEDB", @"MEDS", @"MED", @"MBIO"];
    NSArray *viterbi = @[@"AME", @"ASTE", @"BME", @"CHE", @"CE", @"CSCI", @"EE", @"ENGR", @"ENE", @"ISE", @"INF", @"ITP", @"MASC", @"PTE", @"SAE"];
    NSArray *price = @[@"AEST", @"HMGT", @"MS", @"NAUT", @"NSC", @"PPD", @"PPDE", @"RED", @"PLUS"];
    
    _schoolName = [NSMutableArray arrayWithObjects:
              @{@"title":@"Keck", @"data":keck},
              @{@"title":@"Viterbi", @"data":viterbi},
              @{@"title": @"Price", @"data": price},
              nil];
    _termName = [NSMutableArray arrayWithObjects:@"Summer 15", @"Spring 15", @"Fall 14", @"Summer 14", nil];
    _levelName = [NSMutableArray arrayWithObjects:@"Any", @"Undergrade level", @"Graduate level", nil];
    _termCode = [NSMutableArray arrayWithObjects:@"20152", @"20151", @"20143", @"20142", nil];
    
    _currentSchoolIndex = 0;
    _currentTermIndex = 0;
    _currentLevelIndex = 0;
    _currentDeptIndex = 0;

    NSDictionary *menuDic = [_schoolName objectAtIndex:0];
    _currentDeptCode = [[menuDic objectForKey:@"data"] objectAtIndex:0];

    // [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCourseList:(NSString*)term withDept:(NSString*)dept{
    NSString * url = [[NSString alloc] initWithFormat:@"http://petri.esd.usc.edu/socAPI/Courses/%@/%@", term, dept];
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

// Dropdown Menu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentSchoolIndex;
        
    }
    if (column==1) {
        
        return _currentTermIndex;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {

            return _schoolName.count;
        } else{
            
            NSDictionary *menuDic = [_schoolName objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        
        return _termName.count;
        
    } else if (column==2){
        
        return _levelName.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return [[_schoolName[_currentSchoolIndex] objectForKey:@"data"] objectAtIndex:_currentDeptIndex];
            break;
        case 1:
            return _termName[_currentTermIndex];
            break;
        case 2: return _levelName[_currentLevelIndex];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_schoolName objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_schoolName objectAtIndex:leftRow];
            
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        
        return _termName[indexPath.row];
        
    } else {
        
       return _levelName[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentSchoolIndex = indexPath.row;
        }else{
            NSDictionary *menuDic = [_schoolName objectAtIndex:_currentSchoolIndex];
            _currentDeptIndex = indexPath.row;
            _currentDeptCode = [[menuDic objectForKey:@"data"] objectAtIndex:_currentDeptIndex];
            [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
        }
        
    } else if(indexPath.column == 1){
        _currentTermIndex = indexPath.row;
        [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
    } else{
        _currentLevelIndex = indexPath.row;
    }
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

#pragma mark - Methods

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", [_courseCode objectAtIndex:indexPath.row],
                               [_courseTitle objectAtIndex: indexPath.row]]];
}

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _courseNo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *viewController = [[DetailViewController alloc] init];
    viewController._courseID = [_courseID[indexPath.row] intValue];
    viewController._termCode = [_termCode[_currentTermIndex] intValue];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        style = UITableViewStylePlain;
    }
    return self;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    return menu;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
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
    NSError *jsonParsingError = nil;
    NSMutableArray *JSONData = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&jsonParsingError];
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
        return;
    }
    
    _courseNo = (int)JSONData.count;
    _courseTitle = [[NSMutableArray alloc] initWithCapacity: _courseNo];
    _courseCode = [[NSMutableArray alloc] initWithCapacity:_courseNo];
    _courseID = [[NSMutableArray alloc] initWithCapacity:_courseNo];
    
    for (NSMutableDictionary *dictionary in JSONData)
    {
        NSString *arrayString = dictionary[@"TITLE"];
        if (arrayString)
        {
            [_courseTitle addObject:dictionary[@"TITLE"]];
            [_courseCode addObject:dictionary[@"SIS_COURSE_ID"]];
            [_courseID addObject:dictionary[@"COURSE_ID"]];
        }
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
