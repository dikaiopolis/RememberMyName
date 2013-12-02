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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5)
    {

    [PFUser logOut];
    [self performSegueWithIdentifier:@"logOutSegue" sender:self];
    }

}


@end
