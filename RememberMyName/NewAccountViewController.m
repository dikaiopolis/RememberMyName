//
//  NewAccountViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/21/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "NewAccountViewController.h"
#import <Parse/Parse.h>

@interface NewAccountViewController ()

@end

@implementation NewAccountViewController
@synthesize emailTextField, nameTextField, passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] navigationBar].hidden = NO;
}

-(void)signUpUser
{
    NSString *email = [NSString stringWithString:emailTextField.text];
    PFUser *user = [PFUser user];
    user.username = email;
    user.password = passwordTextField.text;
    user.email = email;
    user[@"name"] = nameTextField.text;
    [[PFUser currentUser] saveInBackground];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
      if (!error) {
        [self performSegueWithIdentifier:@"SegueFromAddAccountVCToUserProfileVC" sender:self];
        } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save failed." message:@"Fill out the information again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
                }
    }];

}
- (IBAction)onSignUpButtonPressed:(id)sender
{
    [self signUpUser];
}
@end
