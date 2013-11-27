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
@synthesize nameTextField, phoneTextField, emailTextField, twitterTextField, imageView, picker;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    PFUser *user = [PFUser currentUser];
    nameTextField.text = [user objectForKey:@"name"];
    phoneTextField.text = [user objectForKey:@"phone"];
    emailTextField.text = [user objectForKey:@"email"];
    twitterTextField.text = [user objectForKey:@"twitter"];
    
     PFFile *imageFile = [[PFUser currentUser] objectForKey:@"picture"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            imageView.image = [UIImage imageWithData:data];
        }
    }];


}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
    
       PFUser *user = [PFUser currentUser];
       user[@"phone"] = phoneTextField.text;
       user[@"name"] = nameTextField.text;
       user[@"email"] = emailTextField.text;
       user[@"username"] = emailTextField.text;
       user[@"twitter"] = twitterTextField.text;
       
         [[PFUser currentUser] saveInBackground];
    }
    [super viewWillDisappear:animated];
}

- (IBAction)onUpdatePhotoButtonPressed:(id)sender {


    picker = [UIImagePickerController new];
    picker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)Picker {
    [Picker dismissViewControllerAnimated:YES completion:Nil];
}

-(void) imagePickerController:(UIImagePickerController *)Picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imageView.image = image;
    
    [Picker dismissViewControllerAnimated:YES completion:Nil];
    
    NSData *pictureImageData = UIImageJPEGRepresentation(image, 0.05f);
    
    [self uploadImage:pictureImageData];
    
}
-(void)uploadImage:(NSData *)image{
   NSData *pictureImageData = UIImageJPEGRepresentation(imageView.image, 0.5);
    PFFile *anImageFile = [PFFile fileWithName:@"Image.jpg" data:pictureImageData];
    [anImageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
             PFUser *user = [PFUser currentUser];
             user[@"picture"] = anImageFile;
             [[PFUser currentUser] saveInBackground];
        }
    }];
    
}

@end
