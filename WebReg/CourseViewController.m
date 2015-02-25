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
    
    NSArray *IovineDesc = @[ @"Arts, Technology and the Business of Innovation", ];
    NSArray *LeventhalDesc = @[ @"Accounting", ];
    NSArray *AnnenbergDesc = @[ @"Communication and Journalism", @"Communication Management", @"Public Diplomacy", @"Journalism", @"Communication", ];
    NSArray *ArchitectureDesc = @[ @"Architecture", ];
    NSArray *MarshallDesc = @[ @"Business Entrepreneurship", @"Business Administration", @"Business Communication", @"Data Sciences and Operations", @"Management and Organization", @"Graduate School of Business Administration", @"Library and Information Management", @"Marketing", @"Finance and Business Economics", ];
    NSArray *CinematicDesc = @[ @"Motion Picture Producing", @"Cinematic Arts", @"Animation", @"Media Arts and Practice", @"Interactive Media", @"Production", @"Writing", @"Critical Studies", ];
    NSArray *KaufmanDesc = @[ @"Dance", ];
    NSArray *OstrowDesc = @[ @"Advanced Dental Education Conjoint Program", @"Periodontics", @"Dentistry", @"Craniofacial Biology", @"Dental Biochemistry", @"Dentistry History", @"Dental Hygiene", @"Oral Diagnosis and Radiology", @"Dental Problem Based Learning", @"DPHR", @"Geriatric Dentistry", @"Occlusion", @"Orofacial Pain and Oral Medicine", @"Oral Medicine Oral Diagnosis", @"Pediatric Dentistry", @"Anatomy", ];
    NSArray *PhysicalDesc = @[ @"Physical Therapy", @"Biokinesiology", ];
    NSArray *RossierDesc = @[ @"Education Counseling", @"Education", @"Higher and Postsecondary Education", ];
    NSArray *ViterbiDesc = @[ @"Aerospace and Mechanical Engineering", @"Systems Architecting and Engineering", @"Biomedical Engineering", @"Chemical Engineering", @"Civil Engineering", @"Computer Science", @"Electrical Engineering", @"Environmental Engineering", @"Engineering", @"Industrial and Systems Engineering", @"Informatics", @"Information Technology Program", @"Materials Science", @"Petroleum Engineering", @"Astronautical Engineering", ];
    NSArray *RoskiDesc = @[ @"Fine Arts", @"Ceramics", @"Critical Studies", @"Design", @"Drawing", @"Public Art Studies", @"Photography", @"Painting", @"Printmaking", @"Sculpture", @"Intermedia", ];
    NSArray *GeneralDesc = @[ @"Category I: Western Cultures and Traditions", @"Category II: Global Cultures and Traditions", @"Category VI: Social Issues", @"Category IV: Science and Its Significance", @"Category V: Arts and Letters", @"Category III: Scientific Inquiry", ];
    NSArray *GerontologyDesc = @[ @"Gerontology", ];
    NSArray *GraduateDesc = @[ @"Graduate Studies", ];
    NSArray *DornsifeDesc = @[ @"Art History", @"Writing", @"American Studies and Ethnicity", @"Anthropology", @"Astronomy", @"Biological Sciences", @"Chemistry", @"Classics", @"Comparative Literature", @"Thematic Option", @"Comparative Studies in Literature and Culture", @"East Asian Languages and Cultures", @"East Asian Studies", @"Economics", @"English", @"Environmental Studies Program", @"Kinesiology", @"French", @"Freshman Seminars", @"Geography", @"Geological Sciences", @"German", @"Gender Studies", @"Greek", @"Hebrew", @"History", @"Human Biology", @"Interdisciplinary Major Program", @"International Relations", @"Italian", @"Judaic Studies", @"Latin", @"Liberal Studies", @"Linguistics", @"Mathematics", @"Multidisciplinary Activities", @"Middle East Studies", @"Master of Professional Writing", @"Neuroscience", @"Neuroscience - Graduate", @"Ocean Sciences", @"Political Economy and Public Policy", @"Physical Education", @"Philosophy", @"Physics", @"Political Science and International Relations", @"Portuguese", @"Political Science", @"Psychology", @"Religion", @"Slavic Languages and Literatures", @"Sociology", @"Spanish", @"Spatial Sciences", @"Sophomore Seminar", @"University of Southern California", @"American Language Institute", ];
    NSArray *LawDesc = @[ @"Law", ];
    NSArray *KeckDesc = @[ @"Academic Medicine", @"Stem Cell Biology and Regenerative Medicine", @"Biochemistry", @"Cancer Biology & Genomics", @"Cell and Neurobiology", @"Development, Stem Cells and Regenerative Medicine", @"Health Promotion and Disease Prevention Studies", @"Interdepartmental", @"Medicine", @"Medical Biology", @"Medical Sciences", @"Molecular Microbiology and Immunology", @"Molecular Structure & Signaling", @"Pathology", @"Physiology and Biophysics", @"Preventive Medicine", @"Primary Care Physician Assistant", @"Anesthesiology", ];
    NSArray *ThorntonDesc = @[ @"Arts Leadership", @"Music", @"Sacred Music", @"Choral Music", @"Composition", @"Conducting", @"Music Education", @"Music Ensemble", @"Music History and Literature", @"Music Industry", @"Jazz Studies", @"Performance (Early Music)", @"Performance (Guitar)", @"Performance (Keyboard Studies)", @"Performance (Popular Music)", @"Performance (Strings)", @"Performance (Vocal Arts)", @"Performance (Winds and Percussion)", @"Music Technology", ];
    NSArray *OccupationalDesc = @[ @"Occupational Science and Occupational Therapy", ];
    NSArray *PharmacyDesc = @[ @"Healthcare Decision Analysis", @"Molecular Pharmacology and Toxicology", @"Regulatory Science", @"Pharmaceutical Economics and Policy", @"Pharmaceutical Sciences", @"Pharmacy", ];
    NSArray *PriceDesc = @[ @"Health Care Management", @"Military Science", @"Nautical Science", @"Real Estate Development", @"Policy, Planning and Development", @"Policy, Planning and Development Expanded", @"Urban and Regional Planning", @"Naval Science", ];
    NSArray *SocialDesc = @[ @"Social Work", ];
    NSArray *DramaticDesc = @[ @"Dramatic Arts", ];
    NSArray *schoolDesc = @[@""];
    _schoolName = [NSMutableArray arrayWithObjects:
                   @{@"title":@"School", @"data":school, @"desc":schoolDesc},
                   @{@"title":@"Iovine", @"data":Iovine, @"desc":IovineDesc},
                   @{@"title":@"Leventhal", @"data":Leventhal, @"desc":LeventhalDesc},
                   @{@"title":@"Annenberg", @"data":Annenberg, @"desc":AnnenbergDesc},
                   @{@"title":@"Architecture", @"data":Architecture, @"desc":ArchitectureDesc},
                   @{@"title":@"Marshall", @"data":Marshall, @"desc":MarshallDesc},
                   @{@"title":@"Cinema", @"data":Cinema, @"desc":CinematicDesc},
                   @{@"title":@"Kaufman", @"data":Kaufman, @"desc":KaufmanDesc},
                   @{@"title":@"Ostrow", @"data":Ostrow, @"desc":OstrowDesc},
                   @{@"title":@"PhyTherapy", @"data":PhysicalTherapy, @"desc":PhysicalDesc},
                   @{@"title":@"Rossier", @"data":Rossier, @"desc":RossierDesc},
                   @{@"title":@"Viterbi", @"data":Viterbi, @"desc":ViterbiDesc},
                   @{@"title":@"Roski", @"data":Roski, @"desc":RoskiDesc},
                   @{@"title":@"GeneralEdu", @"data":GeneralEdu, @"desc":GeneralDesc},
                   @{@"title":@"Gerontology", @"data":Gerontology, @"desc":GerontologyDesc},
                   @{@"title":@"GradStudies", @"data":GraduateStudies, @"desc":GraduateDesc},
                   @{@"title":@"Dornsife", @"data":Dornsife, @"desc":DornsifeDesc},
                   @{@"title":@"Law", @"data":Law, @"desc":LawDesc},
                   @{@"title":@"Keck", @"data": Keck, @"desc":KeckDesc},
                   @{@"title":@"Thornton", @"data":Thornton, @"desc":ThorntonDesc},
                   @{@"title":@"OT", @"data":OccupationalScience, @"desc":OccupationalDesc},
                   @{@"title":@"Pharmacy", @"data":Pharmacy, @"desc":PharmacyDesc},
                   @{@"title":@"Price", @"data":Price, @"desc":PriceDesc},
                   @{@"title":@"SocialWork", @"data":SocialWork, @"desc":SocialDesc},
                   @{@"title":@"DramaticArts", @"data":DramaticArts, @"desc":DramaticDesc},
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
            NSString * info;
            if (leftRow){
                info = [NSString stringWithFormat:@"%@-%@",
                               [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row],
                               [[menuDic objectForKey:@"desc"] objectAtIndex:indexPath.row]];
            }else{
                info = @"Department";
            }
            return info;
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
