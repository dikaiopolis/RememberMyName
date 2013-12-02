//
//  UserDetailViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 12/2/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "UserDetailViewController.h"
#import <Parse/Parse.h>

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController
@synthesize imageView, nameLabel, companyLabel, titleLabel, notesTextView, person;



- (void)viewDidLoad
{
    [super viewDidLoad];
    imageView.image = person.picture;
    companyLabel.text = person.company;
    titleLabel.text = person.jobTitle;}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveButtonPressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    PFQuery *saveUserQuery = [PFUser query];
    [saveUserQuery whereKey:@"objectId" equalTo:person.userID];
    NSMutableArray *userToSaveArray = [saveUserQuery findObjects].mutableCopy;
    PFUser *userToSaved = [userToSaveArray objectAtIndex:0];
    PFRelation *savedUserRelation = [user relationforKey:@"savedUsers"];
    [savedUserRelation addObject:userToSaved];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
        NSLog(@"Error %@ %@", error, [error userInfo]);
        }
    }];
    
    
}
@end
