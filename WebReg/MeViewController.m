//
//  MeViewController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/23.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "MeViewController.h"
#import "RDVTabBarController.h"
#import "XHPathCover.h"
#import "TFTableViewCell.h"

@interface MeViewController ()
{
    NSMutableArray *_settingEntries;
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
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Zheng", XHUserNameKey, @"1991-11-30", XHBirthdayKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

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
    
    TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setText:_settingEntries[indexPath.row]];
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"settings@%ld.png", indexPath.row]]];
        [cell.imageView setFrame:CGRectMake(8, 8, 16, 16)];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0f;;
}


@end
