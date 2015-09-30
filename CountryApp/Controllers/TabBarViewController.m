//
//  TabBarViewController.m
//  CountryApp
//
//  Created by Оксана on 30.09.15.
//  Copyright © 2015 ITCraft. All rights reserved.
//

#import "TabBarViewController.h"
#import <MapKit/MapKit.h>
#import "MagicalRecord.h"
#import "Country.h"

@interface TabBarViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSMutableArray *pins;
@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *allCountries = [Country MR_findAll];
    self.pins = [NSMutableArray array];
    for (Country *country in allCountries) {
        
        CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(country.latitudeValue, country.longitudeValue);
        
        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        pin.coordinate = zoomLocation;
        pin.subtitle = country.capital;
        pin.title    = country.title;
        [self.pins addObject:pin];
        [self.mapView addAnnotation:pin];
    }

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotationPoint
{
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationIdentifier" ];

    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotationPoint reuseIdentifier:@"annotationIdentifier"];
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
    }
    
    return pinView;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self.mapView removeAnnotations:self.pins];
}
@end
