//
//  LeftToRightSegue.m
//  RememberMyName
//
//  Created by Daniel Baldwin on 11/26/13.
//  Copyright (c) 2013 Dnlbldwn. All rights reserved.
//

#import "LeftToRightSegue.h"
#import <QuartzCore/QuartzCore.h>

@implementation LeftToRightSegue

-(void)perform
{
         
   UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
   UIViewController *destinationController = (UIViewController*)[self destinationViewController];                   
     
    CATransition* transition = [CATransition animation];
    transition.duration = .40;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
     
     
     
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
     
    [sourceViewController.navigationController pushViewController:destinationController animated:YES];

}

@end
