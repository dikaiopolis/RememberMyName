//
//  LoginViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/21/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onLoginButtonPressed:(id)sender;
- (IBAction)onForgotPasswordButtonPressed:(id)sender;

-(void)loginUser;

@end
