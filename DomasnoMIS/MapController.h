//
//  MapController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/26/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface MapController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKCircle *curcle;
@property (strong, nonatomic) MKCircle *curclefinki;
@property (strong, nonatomic) CLLocation *finki;
- (IBAction)location:(id)sender;
- (IBAction)finkiLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *rastojanie;
- (IBAction)rastojanieFunk:(id)sender;

@end
