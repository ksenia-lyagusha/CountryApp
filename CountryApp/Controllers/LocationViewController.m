//
//  LocationViewController.m
//  CountryApp
//
//  Created by Оксана on 28.09.15.
//  Copyright © 2015 ITCraft. All rights reserved.
//

#import "LocationViewController.h"

#define METERS_PER_MILE 1609.344

@interface LocationViewController () 

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property MKPointAnnotation *pin;
@property BOOL isFirst;
@property (copy) void(^coordinatesHandler)(CLLocationCoordinate2D);

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(selectLocation:)];
    [self.mapView addGestureRecognizer:longPressRecognizer];
    
    self.pin = [[MKPointAnnotation alloc] init];
    if (self.coordinates2D.latitude) {
        
        CLLocationCoordinate2D coordinates = self.coordinates2D;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinates, 1500*METERS_PER_MILE, 1500*METERS_PER_MILE);
         [_mapView setRegion:viewRegion animated:YES];
        
        self.pin.coordinate = self.coordinates2D;
        [self.mapView addAnnotation:self.pin];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    // block
    if (self.coordinatesHandler) {
        self.coordinatesHandler(self.pin.coordinate);
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
        
        // delegate
//        [self.delegate obtainCoordinates:coordinates];
        
        // notification
//        NSValue *value = [NSValue valueWithMKCoordinate:coordinates];
//        NSDictionary *userInfo = @{@"coord2D" : value};
//        
//        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
//        [notification postNotificationName:@"TestNotification" object:self userInfo:userInfo];
        
        self.pin.coordinate = coordinates;
        [self.mapView addAnnotation:self.pin];
        
        self.isFirst = NO;
    }
}
// block
- (void)fetchCoordinatesWithBlock:(void (^)(CLLocationCoordinate2D ))coordinatesBlock
{
    self.coordinatesHandler = coordinatesBlock;
}

@end
