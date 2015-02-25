//
//  MeViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/23.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "MeViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "XHPathCover.h"
#import "MCSwipeTableViewCell.h"
#import "ViewController.h"
#import "TFNotificationTableViewController.h"
#import "TFCourseTableViewController.h"
#import "MLPAccessoryBadge.h"

@interface MeViewController ()
{
    NSMutableArray *_settingEntries;
    MLPAccessoryBadge * accessoryBadge;
}
@property (nonatomic, strong) XHPathCover *pathCover;
@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Me";
        self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    }
    return self;
}

- (void)viewDidLoad {
    _settingEntries = [NSMutableArray arrayWithObjects:@"Notifications", @"My Courses", @"Profile", @"Logout",nil];
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
    NSURL *imageURL = [NSURL URLWithString:@"https://avatars1.githubusercontent.com/u/2356099?v=3&u=c7e77010e58fcc7203f9538db16edf39aa5460ca&s=140"];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"USC-Campus-Night-PC.jpg"]];
    [_pathCover setAvatarImage:[UIImage imageWithData:imageData]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] stringForKey:@"Username"], XHUserNameKey, @"Fight on! Trojan!", XHBirthdayKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[self rdv_tabBarItem] setBadgeValue:@"3"];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillDisappear:animated];
}
#pragma mark - scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setText:_settingEntries[indexPath.row]];
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"settings@%ld.png", (long)indexPath.row]]];
        [cell.imageView setFrame:CGRectMake(8, 8, 16, 16)];
    }
    if (indexPath.row == 0){
        NSInteger _nitem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"notificationTitles"] count];
        accessoryBadge = [MLPAccessoryBadge new];
        [accessoryBadge setTextWithIntegerValue: _nitem];
        [cell setAccessoryView:accessoryBadge];
        [accessoryBadge.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        [accessoryBadge setCornerRadius:3];
        [accessoryBadge setHighlightAlpha:0];
        [accessoryBadge setShadowAlpha:0];
        [accessoryBadge setBackgroundColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
        [accessoryBadge setGradientAlpha:0];
        if (_nitem == 0){
            // NSLog(@"No");
            [cell.accessoryView setHidden:YES];
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0){
        // Notification
        TFNotificationTableViewController *viewController = [[TFNotificationTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 1){
        // My course
        TFCourseTableViewController *viewController = [[TFCourseTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 3){
        // Logout button
        NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:add animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;;
}


@end
