//
//  LocationViewController.m
//  CountryApp
//
//  Created by Оксана on 28.09.15.
//  Copyright © 2015 ITCraft. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController () 

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *pin;
@property BOOL isFirst;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(selectLocation:)];
    [self.mapView addGestureRecognizer:longPressRecognizer];
    
    self.pin = [[MKPointAnnotation alloc] init];
    if (self.coordinates2D.latitude) {
        self.pin.coordinate = self.coordinates2D;
        [self.mapView addAnnotation:self.pin];
    }
}

- (void)selectLocation:(UILongPressGestureRecognizer *)recognizer
{
    if (self.isFirst) {
        [self.mapView removeAnnotation:self.pin];
        self.isFirst = YES;
        
    } else {

        CGPoint touchPoint = [recognizer locationInView:self.mapView];
        CLLocationCoordinate2D coordinates = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

        [self.delegate obtainCoordinates:coordinates];
        
        self.pin.coordinate = coordinates;
        [self.mapView addAnnotation:self.pin];
        
        self.isFirst = NO;
    }
}


@end
