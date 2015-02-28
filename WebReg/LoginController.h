//
//  LoginController.h
//  WebReg
//
//  Created by Student on 2/10/15.
//  Copyright (c) 2015 TFBoys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController{
    
    IBOutlet UITextField *LoginUsername;
    IBOutlet UITextField *LoginPassword;
    IBOutlet UIScrollView *LoginScroll;
}

- (IBAction)SignUp:(id)sender;
- (IBAction)LoginSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end

