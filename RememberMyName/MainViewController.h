//
//  MainViewController.h
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

-(void)runParseQuery;
- (IBAction)onSettingsButtonPressed:(id)sender;

@end
