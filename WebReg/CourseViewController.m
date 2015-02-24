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
#import "TFTableViewCell.h"
#import "TFTableViewController.h"

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
    
    TFTableViewController * tfTableViewController;
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
    
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    
    tfTableViewController = [[TFTableViewController alloc] init];
    tfTableViewController.tableView.frame = CGRectMake(0, 45, self.view.bounds.size.width, self.view.bounds.size.height - 45);
    [self addChildViewController:tfTableViewController];
    [self.view addSubview:tfTableViewController.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                [tfTableViewController getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode withLevel:_currentLevelIndex];
        }
        
    } else if(indexPath.column == 0){
        _currentTermIndex = indexPath.row;
        if (_currentSchoolIndex)
            [tfTableViewController getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode withLevel:_currentLevelIndex];
    } else{
        _currentLevelIndex = indexPath.row;
        if (_currentSchoolIndex)
            [tfTableViewController getCourseList:_termCode[_currentTermIndex] withDept: _currentDeptCode withLevel:_currentLevelIndex];
    }
}

@end
