//
//  CountryModel.h
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
- (NSInteger)countOfCountries;
- (NSString*)getNameOfCountryForIndex:(NSInteger)numberOfRow;
- (NSString*)getNameOfCapitalForIndex:(NSInteger)numberOfRow;

@end
