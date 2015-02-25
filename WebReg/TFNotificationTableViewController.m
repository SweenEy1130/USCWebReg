//
//  MCTableViewController.m
//  MCSwipeTableViewCell
//
//  Created by Ali Karagoz on 24/02/13.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "MCSwipeTableViewCell.h"
#import "TFNotificationTableViewController.h"
#import "RDVTabBarController.h"

@interface TFNotificationTableViewController () <MCSwipeTableViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) NSArray *notificationTitles;
@property (nonatomic, assign) NSArray *notificationDescriptions;

@property (nonatomic, assign) NSUInteger nbItems;
@property (nonatomic, strong) MCSwipeTableViewCell *cellToDelete;

@end

@implementation TFNotificationTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.notificationTitles = [NSArray arrayWithObjects: @"CSCI-571", @"CSCI-555", @"CSCI-561", @"CSCI-561", @"CSCI-555", @"CSCI-570", nil];
        self.notificationDescriptions = [NSArray arrayWithObjects: @"Homework 2 ends on Mar 10th.", @"Lab 3 ends on Mar 1st.", @"Midterm II will be on Mar 25nd.", @"Homework 2 has been released.", @"Quiz two is on Mar 2nd", @"Midterm I grades has been released.", nil];
        _nbItems = [self.notificationDescriptions count];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Notifications";

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
    UIView *crossView = [self viewWithImageName:@"Cross"];
    UIColor *redColor = [UIColor colorWithRed:232.0 / 255.0 green:61.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];

    // Setting the default inactive state color to the tableView background color
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    
    [cell setDelegate:self];
    
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"settings@0.png"]]];
    [cell.imageView setFrame:CGRectMake(8, 8, 10, 10)];

    [cell.textLabel setText: [self.notificationTitles objectAtIndex:indexPath.row]];
    [cell.textLabel setTextColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];

    [cell.detailTextLabel setText: [self.notificationDescriptions objectAtIndex:indexPath.row]];
    [cell.detailTextLabel setFont: [UIFont systemFontOfSize:14.0]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:63.0/255.0 green:59/255.0 blue:59/255.0 alpha:1.0]];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setSwipeGestureWithView:crossView color:redColor mode:MCSwipeTableViewCellModeExit state:MCSwipeTableViewCellState1 completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
        // NSLog(@"Did swipe \"Cross\" cell");
        [self deleteCell:cell];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // MCTableViewController *tableViewController = [[MCTableViewController alloc] init];
    // [self.navigationController pushViewController:tableViewController animated:YES];
}

#pragma mark - MCSwipeTableViewCellDelegate


// When the user starts swiping the cell this method is called
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did start swiping the cell!");
}

// When the user ends swiping the cell this method is called
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell {
    // NSLog(@"Did end swiping the cell!");
}

// When the user is dragging, this method is called and return the dragged percentage from the border
- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage {
    // NSLog(@"Did swipe with percentage : %f", percentage);
}

#pragma mark - Utils
- (void)deleteCell:(MCSwipeTableViewCell *)cell {
    NSParameterAssert(cell);
    
    _nbItems--;
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
