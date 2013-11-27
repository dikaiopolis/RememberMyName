//
//  SettingsTableViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <Parse/Parse.h>

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController
@synthesize nameLabel, imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    PFUser *user = [PFUser currentUser];
    nameLabel.text = [user objectForKey:@"name"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source




@end
