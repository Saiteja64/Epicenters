//
//  MapPin.h
//  Epicenters
//
//  Created by Saiteja Samudrala on 7/22/14.
//  Copyright (c) 2014 edu.foothill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation>
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic)NSString * magnitude;
@property (nonatomic)NSString * place;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate magnitude: (NSString*)magnitude place: (NSString*)place;
-(NSString*)title ;
-(NSString*)subtitle;
@end
