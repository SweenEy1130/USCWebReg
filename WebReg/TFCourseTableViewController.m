//
//  TFCourseTableViewController.m
//  USCholar
//
//  Created by ZhengLi on 15/2/25.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "TFCourseTableViewController.h"
#import "MCSwipeTableViewCell.h"
#import "RDVTabBarController.h"

@interface TFCourseTableViewController ()<MCSwipeTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *mycourseTitle;
@property (nonatomic, strong) NSMutableArray *mycourseDesc;

@property (nonatomic, assign) NSInteger nbItems;

@end

@implementation TFCourseTableViewController


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _nbItems =[[[NSUserDefaults standardUserDefaults] objectForKey:@"mycourseTitle"] count];
        _mycourseTitle = [[NSMutableArray alloc] initWithCapacity:_nbItems];
        _mycourseDesc = [[NSMutableArray alloc] initWithCapacity:_nbItems];
        
        [_mycourseTitle  addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"mycourseTitle"]];
        [_mycourseDesc addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"mycourseDesc"]];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"My Courses";
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:227.0 / 255.0 green:227.0 / 255.0 blue:227.0 / 255.0 alpha:1.0]];
    [self.tableView setBackgroundView:backgroundView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _nbItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell.textLabel setText: [_mycourseTitle objectAtIndex:indexPath.row]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
    
    [cell.detailTextLabel setText: [_mycourseDesc objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setFont: [UIFont systemFontOfSize:14.0]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
    
    // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // MCTableViewController *tableViewController = [[MCTableViewController alloc] init];
    // [self.navigationController pushViewController:tableViewController animated:YES];
}
@end
