//
//  TabbarController.m
//  WebReg
//
//  Created by ZhengLi on 15/2/13.
//  Copyright (c) 2015年 TFBoys. All rights reserved.
//

#import "TabbarController.h"
#import "CourseViewController.h"
#import "MeViewController.h"
#import "RDVTabBarItem.h"
#import "WeeklyViewController.h"

@interface TabbarController () <UITabBarControllerDelegate>

@end

@implementation TabbarController
- (id) init
{
    self = [super init];
    if (self)
    {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WeeklyViewController *firstViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeeklyViewController"];
    firstViewController.title = @"Calendar";
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[CourseViewController alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[MeViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    [self setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal@2x",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal@2x",
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
                       };
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController
{
    if ([viewController.title isEqualToString:@"Calendar"])
    {
        NSLog(@"Switch to Calendar tab");
        // Cast the view controller to the appropriate type
        UINavigationController * tNavCtrl = (UINavigationController*)viewController;
        WeeklyViewController * tWVCtrl = (WeeklyViewController *)[tNavCtrl.viewControllers objectAtIndex:0];
        [tWVCtrl reloadEvents];
    }
}
@end
