//
//  MapPin.m
//  Epicenters
//
//  Created by Saiteja Samudrala on 7/22/14.
//  Copyright (c) 2014 edu.foothill. All rights reserved.
//

#import "MapPin.h"
#import <MapKit/MapKit.h>

@implementation MapPin
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate magnitude:(NSString *)magnitude place:(NSString *)place {
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
        _magnitude = magnitude;
        _place = place;
        
    }
    
    return self;
}

-(NSString*)title {
    
    return _magnitude;
}

-(NSString*)subtitle {
    
    return _place;
    
}
@end
