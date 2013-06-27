//
//  MapController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/26/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "MapController.h"

@implementation MapController
@synthesize rastojanie;
@synthesize mapView;
@synthesize locationManager;
@synthesize curcle;
@synthesize curclefinki;
@synthesize finki;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    finki = [[CLLocation alloc] initWithLatitude:42.00415 longitude:21.409471];
    // Do any additional setup after loading the view from its nib.
    /*locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    curcle = [MKCircle circleWithCenterCoordinate:locationManager.location.coordinate radius:10];
    curclefinki= [MKCircle circleWithCenterCoordinate:locationManager.location.coordinate radius:10];
    
    [mapView addOverlay:curcle];
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0 , 0.0}};
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.007f;
    region.span.latitudeDelta = 0.007f;
    [mapView setRegion:region animated:YES];*/
    mapView.delegate = self;
    
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setLocationManager:nil];
    [self setRastojanie:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    if(overlay == curclefinki){
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor blueColor];
    circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        return circleView;}
    else{
        MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
        circleView.strokeColor = [UIColor redColor];
        circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
        return circleView;
    }
}
- (IBAction)rastojanieFunk:(id)sender {
    [mapView removeOverlay:curcle];
    [mapView removeOverlay:curclefinki];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    curcle = [MKCircle circleWithCenterCoordinate:locationManager.location.coordinate radius:10];
    
    [mapView addOverlay:curcle];
    curclefinki = [MKCircle circleWithCenterCoordinate:finki.coordinate radius:10];
    
    [mapView addOverlay:curclefinki];
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0 , 0.0}};
    region.center.latitude = (locationManager.location.coordinate.latitude + finki.coordinate.latitude) / 2; 
    region.center.longitude = (locationManager.location.coordinate.longitude + finki.coordinate.longitude) / 2;
    CLLocationDistance distance = [locationManager.location distanceFromLocation:finki];
    float zoom = (distance/1000)/111;
    region.span.longitudeDelta = zoom;
    region.span.latitudeDelta = zoom;
    [mapView setRegion:region animated:YES];
    if(distance < 1000){
    rastojanie.text = [[NSString alloc] initWithFormat:@"%.2f m",distance];
    }else{
        rastojanie.text = [[NSString alloc] initWithFormat:@"%.2f km",distance/1000];
    }
}
@end
