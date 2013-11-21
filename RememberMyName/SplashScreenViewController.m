//
//  SplashScreenViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/21/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "SplashScreenViewController.h"
#import <Parse/Parse.h>

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[[self navigationController] navigationBar].hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{

    [self performSelector:@selector(checkIfUserLoggedIn) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkIfUserLoggedIn
{

    //Checks to see if a user is logged in and if there is segues to profile and if not segues to login
        if ([PFUser currentUser]) {
        
        [self performSegueWithIdentifier:@"SegueFromSplashScreenVCToUserProfileVC" sender:self];
    } else {
        [self performSegueWithIdentifier:@"SegueFromSplashScreenVCToLoginVC" sender:self];
    }
}

@end
