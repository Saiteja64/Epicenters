//
//  ViewController.h
//  Epicenters
//
//  Created by Saiteja Samudrala on 7/22/14.
//  Copyright (c) 2014 edu.foothill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapPin.h"

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic) float mag;
@end
