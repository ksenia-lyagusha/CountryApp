//
//  MapViewController.m
//  CountryApp
//
//  Created by Оксана on 25.09.15.
//  Copyright © 2015 ITCraft. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DetailInfoController.h"
#import "Country.h"

#define METERS_PER_MILE 1609.344
@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.country.title;
}

- (void)viewWillAppear:(BOOL)animated
{
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(self.country.latitudeValue, self.country.longitudeValue);

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 90*METERS_PER_MILE, 90*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = zoomLocation;
    pin.subtitle = self.country.capital;
    pin.title    = self.country.title;
    
    [self.mapView addAnnotation:pin];
}

- (IBAction)backPosition:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
