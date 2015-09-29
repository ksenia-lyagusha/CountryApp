//
//  LocationViewController.h
//  CountryApp
//
//  Created by Оксана on 28.09.15.
//  Copyright © 2015 ITCraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import <MapKit/MapKit.h>
#import "AddInfoController.h"
@protocol LocationViewDelegate <NSObject>

- (void)obtainCoordinates:(CLLocationCoordinate2D)coordinates;

@end

@interface LocationViewController : UIViewController

@property id <LocationViewDelegate> delegate;
@property CLLocationCoordinate2D coordinates2D;
@end


