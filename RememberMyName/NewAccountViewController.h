//
//  NewAccountViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/21/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onSignUpButtonPressed:(id)sender;

-(void)signUpUser;

@end
