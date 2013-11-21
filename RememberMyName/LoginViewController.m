//
//  LoginViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/21/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize passwordTextField, emailTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] navigationBar].hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginUser
{
            
    NSString *email = [NSString stringWithFormat: @"%@", emailTextField.text];
    NSString *password = [NSString stringWithFormat: @"%@", passwordTextField.text];
    
    if ([email length] < 5 || [password length] < 5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Make sure you fill out all of the information!" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
            if (user) {
                [self performSegueWithIdentifier:@"SegueFromLoginVCToUserProfileVC" sender:self];
            } else {
                NSLog(@"%@",error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed." message:@"Invalid Username and/or Password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

- (IBAction)onLoginButtonPressed:(id)sender
{
    [self loginUser];
}

- (IBAction)onForgotPasswordButtonPressed:(id)sender
{


}


@end
