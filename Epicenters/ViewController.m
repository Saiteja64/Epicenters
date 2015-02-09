//
//  ViewController.m
//  Epicenters
//
//  Created by Saiteja Samudrala on 7/22/14.
//  Copyright (c) 2014 edu.foothill. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Earthquake.h"
#define METERS_PER_MILE 1609.344

@interface ViewController () {
    
    MKPointAnnotation * foothill;
    NSMutableData *responseData;
    NSMutableArray *earthquakes;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    CLLocationCoordinate2D mapCenter;
    mapCenter.latitude = 37.36222;
    mapCenter.longitude = -122.13042;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapCenter, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    [[self mapView]setRegion:viewRegion animated: YES];
    foothill = [[MKPointAnnotation alloc]init];
    foothill.coordinate = mapCenter;
    foothill.title = @"Foothill College";
    foothill.subtitle = @"12345 El Monte Rd, Los Altos, CA 94022";
    [[self mapView]addAnnotation:foothill];
    [[self mapView] setDelegate:self];
responseData = [NSMutableData data];
    earthquakes = [[NSMutableArray alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://earthquake.usgs.gov/earthquakes/feed/v0.1/summary/2.5_month.geojson"]];
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)plotLocations {

    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [[self mapView] removeAnnotation:annotation]; }
    [[self mapView] addAnnotation:foothill];
  
    for (Earthquake *quake in earthquakes) {
    CLLocationCoordinate2D coords;
        coords.longitude = [quake longitude];
        coords.latitude = [quake latitude];
    NSString *mag = [NSString stringWithFormat: @"Magnitude %.2f",[quake magnitude]];
      
    MapPin *annotation = [[MapPin alloc] initWithCoordinate: coords magnitude: mag place: [quake place]];
    [[self mapView] addAnnotation:annotation]; }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection { NSLog(@"connectionDidFinishLoading");
    NSLog(@"Received %d bytes of data",[responseData length]);
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization
                         JSONObjectWithData: responseData options:NSJSONReadingMutableLeaves error: &myError];
    NSArray *results = [res objectForKey:@"features"];
    for (NSDictionary *result in results) {
        NSDictionary *dict = [result objectForKey:@"geometry"];
        NSArray *coords = [dict objectForKey:@"coordinates"]; float longitude = [[coords objectAtIndex:0] floatValue]; float latitude = [[coords objectAtIndex:1] floatValue];
        
        NSDictionary *properties = [result objectForKey:@"properties"];
  
       float mag = [[properties objectForKey:@"mag"] floatValue];
        
        NSString *place = [properties objectForKey:@"place"];
        Earthquake *quake = [[Earthquake alloc] init];
        [quake setLongitude:longitude];
        [quake setLatitude:latitude];
        [quake setMagnitude: mag];
        [quake setPlace: place ];
        [earthquakes addObject:quake];
    }
    
    
[self plotLocations];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"didReceiveData");
    [responseData appendData:data]; }

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error { NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response { NSLog(@"didReceiveResponse");
    [responseData setLength:0]; }

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    NSString * bob = annotation.title;
    NSString * raj = [NSString stringWithFormat:@""];
    NSScanner  * scan = [NSScanner scannerWithString :bob];
    [scan scanString: @"Magnitude" intoString : nil];
    [scan scanUpToString: @"\n" intoString : &raj];
    NSLog(@"%@",raj);
    float d = [raj floatValue];
    static NSString * identifier = @"mapPin";
    MKAnnotationView *annotationView =
    (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        if ([annotation isKindOfClass:[MapPin class]]) {
            NSLog(@"%f",d);
            if(d > 0 && d < 1) {
            annotationView.image = [UIImage imageNamed:@"blue.png"];
            }  if(d > 1 && d <= 2) {
                annotationView.image = [UIImage imageNamed:@"bluepop.png"];
            }
            
            if(d > 2 && d <= 2.7) {
                annotationView.image = [UIImage imageNamed:@"cyan.png"];
            }

            if(d > 2.7 && d <= 3.1) {
                annotationView.image = [UIImage imageNamed:@"grn.png"];
            }   if(d > 3.1 && d <= 5) {
                
                 annotationView.image = [UIImage imageNamed:@"yellow.png"];
            }
            
            if(d > 5 && d <= 6) {
                
                annotationView.image = [UIImage imageNamed:@"orange.png"];
            }
            
            if(d > 6 && d <= 10) {
                
                annotationView.image = [UIImage imageNamed:@"read.png"];
            }



            
            
        } else {
                annotationView.image = [UIImage imageNamed:@"bluepie.png"];
                annotationView.centerOffset = CGPointMake(8, -12.5f); }
    }
    return annotationView; }


@end
