//
//  MainViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "MainViewController.h"
#import "CollectionViewCell.h"
#import "Person.h"
#import "UserDetailViewController.h"
#import <Parse/Parse.h>

@interface MainViewController (){
NSMutableArray *usersNearMeArray;
CLLocationManager *locationManager;
Person *person;
int rowNumber;

}

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{

    [self runParseQuery];
     CLLocation *location = [locationManager location];
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLocation:location];
    PFUser *user = [PFUser currentUser];
       user[@"location"] = userGeoPoint;
    
      [[PFUser currentUser] saveInBackground];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] navigationBar].hidden = NO;
    
}


#pragma mark CollectionViewDelegate and DataSource methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
return 1;
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {

if (usersNearMeArray.count != 0)
    {
    return usersNearMeArray.count;
    } else {
    return 0;
    }
}

-(CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];

    PFObject *imageObject = [usersNearMeArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"picture"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.imageView.image = [UIImage imageWithData:data];
        }
    }];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    rowNumber = (int) indexPath.row;
    [self performSegueWithIdentifier:@"SegueToUserDetailVC" sender:self];

}

//Queries Parse for users near the current user
-(void)runParseQuery
{
        locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self; 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
        locationManager.distanceFilter = kCLDistanceFilterNone; 
        [locationManager startUpdatingLocation];
        
            CLLocation *location = [locationManager location];
    
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLocation:location];
        PFQuery *locationQuery = [PFUser query];
        PFUser *user = [PFUser currentUser];

        [locationQuery whereKey:@"location" nearGeoPoint:userGeoPoint withinKilometers:0.05];
    
        [locationQuery whereKey:@"objectId" notEqualTo:[user valueForKey:@"objectId"]];

        //// Limit what could be a lot of points.
        locationQuery.limit = 50;

        //// Final list of objects
        usersNearMeArray = [locationQuery findObjects].mutableCopy;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(CollectionViewCell *)sender
{
    if ([segue.identifier isEqualToString:@"SegueToUserDetailVC"])
    {
        UserDetailViewController *udvc = [segue destinationViewController];

        PFObject *userObject = [usersNearMeArray objectAtIndex:rowNumber];
        PFFile *imageFile = [userObject objectForKey:@"picture"];
    
        NSData *data = [imageFile getData];
        UIImage *image = [UIImage imageWithData:data];
    
        person.picture = image;
        person.name = [userObject objectForKey:@"name"];
        person.userID = [userObject valueForKey:@"objectId"];
        person.jobTitle = [userObject objectForKey:@"jobTitle"];
        person.company = [userObject objectForKey:@"company"];
        udvc.person = person;
        }
}

//Segues to Settings VC
- (IBAction)onSettingsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueFromMainVCToSettingsVC" sender:self];
}


@end
