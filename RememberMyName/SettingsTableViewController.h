//
//  SettingsTableViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITableViewCell *nameRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *homeRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *myProfileRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *settingsRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *socialNetworksRow;
@property (weak, nonatomic) IBOutlet UITableViewCell *signOutRow;

@end
