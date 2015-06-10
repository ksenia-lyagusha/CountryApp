//
//  CountryModel.h
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CountryInfo.h"
@interface CountryModel : NSObject

+ (CountryModel*)sharedInstance;
- (NSInteger)numberOfContinents;
- (NSString*)titleOfContinentForIndex:(NSInteger)index;
- (NSInteger)countOfCountriesInContinent:(NSString*)continent;
- (CountryInfo*)countryInfoObj:(NSIndexPath*)indexPath;
- (void)deleteObjectFromList:(NSIndexPath*)indexPath;
- (void)addNewObject:(CountryInfo*)countryInfo;

@end
