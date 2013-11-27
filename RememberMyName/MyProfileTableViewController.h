//
//  MyProfileTableViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/27/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterTextField;

@end
