//
//  TabbarController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "TabbarController.h"
#import "CalendarViewController.h"
#import "CourseViewController.h"
#import "DiscoverViewController.h"
#import "RDVTabBarItem.h"

@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIViewController *firstViewController = [[CalendarViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[CourseViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[DiscoverViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    [self setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController]];
    
    [self customizeTabBarForController:self];
    [self customizeInterface];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                       NSForegroundColorAttributeName:
                        [UIColor whiteColor],
                        //  [UIColor colorWithRed:0.514 green:0 blue:0.039 alpha:1] /*#83000a*/,
                        // [UIColor colorWithRed:0.965 green:0.643 blue:0.082 alpha:1] /*#f6a415*/,
                       };
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
@end
