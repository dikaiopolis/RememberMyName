//
//  MyProfileTableViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/27/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "MyProfileTableViewController.h"
#import <Parse/Parse.h>

@interface MyProfileTableViewController ()

@end

@implementation MyProfileTableViewController
@synthesize nameTextField, phoneTextField, emailTextField, twitterTextField;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    PFUser *user = [PFUser currentUser];
    nameTextField.text = [user objectForKey:@"name"];
    phoneTextField.text = [user objectForKey:@"phone"];
    emailTextField.text = [user objectForKey:@"email"];
    twitterTextField.text = [user objectForKey:@"twitter"];

}
@end
