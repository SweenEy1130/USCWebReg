//
//  AppDelegate.m
//  WebReg
//
//  Created by Student on 2/10/15.
//  Copyright (c) 2015 TFBoys. All rights reserved.
//

#import "AppDelegate.h"
#import "MeViewController.h"
#import "RDVTabBarController.h"
#import "TabbarController.h"
#import "TFNotificationTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"Username"] != nil){
        RDVTabBarController *tabbarController = [[TabbarController alloc] init];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [self.window setRootViewController:tabbarController];
    }else{
        // Set default value
        NSArray *notificationTitles = [NSArray arrayWithObjects: @"CSCI-571", @"CSCI-555", @"CSCI-561", @"CSCI-561", @"CSCI-555", @"CSCI-570", nil];
        NSArray *notificationDescriptions = [NSArray arrayWithObjects: @"Homework 2 ends on Mar 10th.", @"Lab 3 ends on Mar 1st.", @"Midterm II will be on Mar 25nd.", @"Homework 2 has been released.", @"Quiz two is on Mar 2nd", @"Midterm I grades has been released.", nil];
        [[NSUserDefaults standardUserDefaults] setObject:notificationTitles forKey:@"notificationTitles"];
        [[NSUserDefaults standardUserDefaults] setObject:notificationDescriptions forKey:@"notificationDescriptions"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSArray *mycourseTitle = [NSArray arrayWithObjects: @"CSCI-571", @"CSCI-555", @"CSCI-561",nil];
        NSArray *mycourseDesc = [NSArray arrayWithObjects: @"TH 19:00-20:20", @"M 14:00-16:50", @"TH 17:00-18.20",nil];

        [[NSUserDefaults standardUserDefaults] setObject:mycourseTitle forKey:@"mycourseTitle"];
        [[NSUserDefaults standardUserDefaults] setObject:mycourseDesc forKey:@"mycourseDesc"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber--;
}

@end
