//
//  ViewController.m
//  WebReg
//
//  Created by Student on 2/10/15.
//  Copyright (c) 2015 TFBoys. All rights reserved.
//

#import "ViewController.h"
#import "TabbarController.h"
#import "RDVTabBarController.h"
#import "TabbarController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.LoginButton setBackgroundColor:[UIColor colorWithRed:179.0/255.0 green:0/255.0 blue:6.0/255.0 alpha:1.0]];
    LoginPassword.secureTextEntry = YES;
    [self registerForKeyboardNotifications];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUp:(id)sender {
}

- (IBAction)LoginSubmit:(id)sender {    
    NSString *valueToSave = LoginUsername.text;
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"Username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    RDVTabBarController *tabbarController = [[TabbarController alloc] init];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self presentViewController:tabbarController animated:YES completion: nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //[LoginScroll setContentSize: CGSizeMake(260, 220)];
    // NSDictionary* info = [aNotification userInfo];
    [LoginScroll setContentOffset:CGPointMake(0.0f, 50) animated:YES];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [LoginScroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}

@end
