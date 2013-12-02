//
//  UserDetailViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 12/2/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface UserDetailViewController : UIViewController
@property (strong, nonatomic) Person *person;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

- (IBAction)onSaveButtonPressed:(id)sender;
@end
