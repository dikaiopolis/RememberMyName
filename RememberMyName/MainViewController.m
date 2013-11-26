//
//  MainViewController.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "MainViewController.h"
#import "CollectionViewCell.h"
#import <Parse/Parse.h>

@interface MainViewController (){
NSMutableArray *usersNearMeArray;
CLLocationManager *locationManager;
}

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

return 1;
}

-(void)viewDidAppear:(BOOL)animated
{
    [[self navigationController] navigationBar].hidden = NO;
    [self findCurrentLocation];
   CLLocation *location = [locationManager location];
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLocation:location];
    PFUser *user = [PFUser currentUser];
       user[@"location"] = userGeoPoint;
    
      [[PFUser currentUser] saveInBackground];
    
}


#pragma mark CollectionViewDelegate and DataSource methods
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {

    [self findCurrentLocation];
    CLLocation *location = [locationManager location];
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLocation:location];
    PFQuery *locationQuery = [PFUser query];
    PFUser *user = [PFUser currentUser];

    [locationQuery whereKey:@"location" nearGeoPoint:userGeoPoint withinKilometers:0.05];
    
    [locationQuery whereKey:@"objectId" notEqualTo:[user valueForKey:@"objectId"]];


//// Limit what could be a lot of points.
locationQuery.limit = 50;

//// Final list of objects

usersNearMeArray = [[NSMutableArray alloc] init];
usersNearMeArray = [locationQuery findObjects].mutableCopy;
if (usersNearMeArray.count != 0)
    {
    return usersNearMeArray.count;
    } else {
    return 0;
    }
}

-(CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    [self findCurrentLocation];
    CLLocation *location = [locationManager location];
    
    PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLocation:location];
    PFQuery *locationQuery = [PFUser query];
    PFUser *user = [PFUser currentUser];

    [locationQuery whereKey:@"location" nearGeoPoint:userGeoPoint withinKilometers:0.05];
    
    //This causes an error when uncommented.  Not sure why.  Need to remove current user from array.
    [locationQuery whereKey:@"objectId" notEqualTo:[user valueForKey:@"objectId"]];



//// Limit what could be a lot of points.
locationQuery.limit = 50;

//// Final list of objects

usersNearMeArray = [[NSMutableArray alloc] init];
usersNearMeArray = [locationQuery findObjects].mutableCopy;

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

-(void)findCurrentLocation
{
        locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self; 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; 
        locationManager.distanceFilter = kCLDistanceFilterNone; 
        [locationManager startUpdatingLocation];
    }
}

- (IBAction)onSettingsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"SegueFromMainVCToSettingsVC" sender:self];
}


@end
