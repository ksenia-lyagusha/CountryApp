//
//  CountryModel.h
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryModel : NSObject

- (NSInteger)countOfCountriesInContinent:(NSString*)continent;
- (NSNumber*)getPopulationOfCapitalForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index;
- (NSString*)getNameOfCountryForContinent:(NSString*)continent atIndex:(NSInteger)index;
- (NSString*)getNameOfCapitalForContinent:(NSString*)continent atIndex:(NSInteger)index;
- (NSString*)titleOfContinentForIndex:(NSInteger)index;
- (NSInteger)numberOfContinents;

@end
