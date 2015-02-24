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
#import "TFTableViewCell.h"

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
        [self.view setBackgroundColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Configure dropdown menu
    NSArray *Iovine = @[@"ACAD"];
    NSArray *Leventhal = @[@"ACCT"];
    NSArray *Annenberg = @[@"ASCJ", @"CMGT", @"PUBD", @"JOUR", @"COMM"];
    NSArray *Architecture = @[@"ARCH"];
    NSArray *Marshall = @[@"BAEP", @"BUAD", @"BUCO", @"DSO",@"MOR",@"GSBA", @"LIM", @"MKT",@"FBE"];
    NSArray *Cinema = @[@"CMPP",@"CNTV", @"CTAN", @"IML", @"CTIN", @"CTPR", @"CTWR", @"CTCS"];
    NSArray *Kaufman = @[ @"DANC", ];
    NSArray *Ostrow = @[ @"ADNT", @"PERI", @"DENT", @"CBY", @"DBIO", @"DHIS", @"DHYG", @"DIAG", @"DPBL", @"DPHR", @"GDEN", @"OCCL", @"OFPM", @"OMOD", @"PEDO", @"ANAT", ];
    NSArray *PhysicalTherapy = @[ @"PT", @"BKN", ];
    NSArray *Rossier = @[ @"EDCO", @"EDUC", @"EDHP", ];
    NSArray *Viterbi = @[ @"AME", @"SAE", @"BME", @"CHE", @"CE", @"CSCI", @"EE", @"ENE", @"ENGR", @"ISE", @"INF", @"ITP", @"MASC", @"PTE", @"ASTE", ];
    NSArray *Roski = @[ @"FA", @"FACE", @"FACS", @"FADN", @"FADW", @"PAS", @"FAPH", @"FAPT", @"FAPR", @"FASC", @"FAIN", ];
    NSArray *GeneralEdu = @[ @"WCT", @"GCT", @"SI", @"SCIS", @"ARLT", @"SCIN", ];
    NSArray *Gerontology = @[ @"GERO", ];
    NSArray *GraduateStudies = @[ @"GRSC", ];
    NSArray *Dornsife = @[ @"AHIS", @"WRIT", @"AMST", @"ANTH", @"ASTR", @"BISC", @"CHEM", @"CLAS", @"COLT", @"CORE", @"CSLC", @"EALC", @"EASC", @"ECON", @"ENGL", @"ENST", @"EXSC", @"FREN", @"FSEM", @"GEOG", @"GEOL", @"GERM", @"SWMS", @"GR", @"HEBR", @"HIST", @"HBIO", @"INDS", @"IR", @"ITAL", @"JS", @"LAT", @"LBST", @"LING", @"MATH", @"MDA", @"MDES", @"MPW", @"NEUR", @"NSCI", @"OS", @"PEPP", @"PHED", @"PHIL", @"PHYS", @"POIR", @"PORT", @"POSC", @"PSYC", @"REL", @"SLL", @"SOCI", @"SPAN", @"SSCI", @"SSEM", @"USC", @"ALI", ];
    NSArray *Law = @[ @"LAW", ];
    NSArray *Keck = @[ @"ACMD", @"SCRM", @"BIOC", @"CBG", @"CNB", @"DSR", @"HP", @"INTD", @"MED", @"MEDB", @"MEDS", @"MICB", @"MSS", @"PATH", @"PHBI", @"PM", @"PCPA", @"ANST", ];
    NSArray *Thornton =@ [ @"ARTL", @"MUSC", @"MSCR", @"MUCM", @"MUCO", @"MUCD", @"MUED", @"MUEN", @"MUHL", @"MUIN", @"MUJZ", @"MPEM", @"MPGU", @"MPKS", @"MPPM", @"MPST", @"MPVA", @"MPWP", @"MTEC", ];
    NSArray *OccupationalScience = @[ @"OT", ];
    NSArray *Pharmacy = @[ @"HCDA", @"MPTX", @"RSCI", @"PMEP", @"PSCI", @"PHRD", ];
    NSArray *Price = @[@"HMGT", @"MS", @"NAUT", @"RED", @"PPD", @"PPDE", @"PLUS", @"NSC", ];
    NSArray *SocialWork = @[ @"SOWK", ];
    NSArray *DramaticArts = @[ @"THTR", ];
    NSArray *school = @[@"Department"];
    _schoolName = [NSMutableArray arrayWithObjects:
                   @{@"title":@"School", @"data":school},
                   @{@"title":@"Iovine", @"data":Iovine},
                   @{@"title":@"Leventhal", @"data":Leventhal},
                   @{@"title":@"Annenberg", @"data":Annenberg},
                   @{@"title":@"Architecture", @"data":Architecture},
                   @{@"title":@"Marshall", @"data":Marshall},
                   @{@"title":@"Cinema", @"data":Cinema},
                   @{@"title":@"Kaufman", @"data":Kaufman},
                   @{@"title":@"Ostrow", @"data":Ostrow},
                   @{@"title":@"PhyTherapy", @"data":PhysicalTherapy},
                   @{@"title":@"Rossier", @"data":Rossier},
                   @{@"title":@"Viterbi", @"data":Viterbi},
                   @{@"title":@"Roski", @"data":Roski},
                   @{@"title":@"GeneralEdu", @"data":GeneralEdu},
                   @{@"title":@"Gerontology", @"data":Gerontology},
                   @{@"title":@"GradStudies", @"data":GraduateStudies},
                   @{@"title":@"Dornsife", @"data":Dornsife},
                   @{@"title":@"Law", @"data":Law},
                   @{@"title":@"Keck", @"data": Keck},
                   @{@"title":@"Thornton", @"data":Thornton},
                   @{@"title":@"OT", @"data":OccupationalScience},
                   @{@"title":@"Pharmacy", @"data":Pharmacy},
                   @{@"title":@"Price", @"data":Price},
                   @{@"title":@"SocialWork", @"data":SocialWork},
                   @{@"title":@"DramaticArts", @"data":DramaticArts},
                   nil];
    _termName = [NSMutableArray arrayWithObjects:@"Summer 15", @"Spring 15", @"Fall 14", @"Summer 14", nil];
    _levelName = [NSMutableArray arrayWithObjects:@"All", @"Undergrade", @"Graduate", nil];
    _termCode = [NSMutableArray arrayWithObjects:@"20152", @"20151", @"20143", @"20142", nil];
    
    _currentSchoolIndex = 0;
    _currentTermIndex = 0;
    _currentLevelIndex = 0;
    _currentDeptIndex = 0;

    NSDictionary *menuDic = [_schoolName objectAtIndex:0];
    _currentDeptCode = [[menuDic objectForKey:@"data"] objectAtIndex:0];
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

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    if (column==1) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    if (column==1) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==1) {
        
        return _currentSchoolIndex;
        
    }
    if (column==0) {
        
        return _currentTermIndex;
    }
    
    if (column == 2)
        return  _currentLevelIndex;
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==1) {
        if (leftOrRight==0) {

            return _schoolName.count;
        } else{
            
            NSDictionary *menuDic = [_schoolName objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==0){
        
        return _termName.count;
        
    } else if (column==2){
        
        return _levelName.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 1:
            return [[_schoolName[_currentSchoolIndex] objectForKey:@"data"] objectAtIndex:_currentDeptIndex];
            break;
        case 0:
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
    
    if (indexPath.column==1) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_schoolName objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_schoolName objectAtIndex:leftRow];
            
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==0) {
        
        return _termName[indexPath.row];
        
    } else {
       return _levelName[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 1) {
        
        if(indexPath.leftOrRight==0){
            _currentSchoolIndex = indexPath.row;
        }else{
            NSDictionary *menuDic = [_schoolName objectAtIndex:_currentSchoolIndex];
            _currentDeptIndex = indexPath.row;
            _currentDeptCode = [[menuDic objectForKey:@"data"] objectAtIndex:_currentDeptIndex];
            if (_currentSchoolIndex)
                [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
        }
        
    } else if(indexPath.column == 0){
        _currentTermIndex = indexPath.row;
        if (_currentSchoolIndex)
            [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
    } else{
        _currentLevelIndex = indexPath.row;
        if (_currentSchoolIndex)
            [self getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode];
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

#pragma mark - Table view

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[TFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", [_courseCode objectAtIndex:indexPath.row],
                               [_courseTitle objectAtIndex: indexPath.row]]];
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
    viewController._courseCode = _courseCode[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // style = UITableViewStylePlain;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    _courseNo = 0;
    _courseTitle = [[NSMutableArray alloc] init];
    _courseCode = [[NSMutableArray alloc] init];
    _courseID = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dictionary in JSONData)
    {
        NSString *courseid = dictionary[@"SIS_COURSE_ID"];
        int course_level = [[courseid componentsSeparatedByString:@"-"][1] intValue];
        if (_currentLevelIndex == 1 && course_level >= 400)
            continue;
        if (_currentLevelIndex == 2 && course_level < 400)
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
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
