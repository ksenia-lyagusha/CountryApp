//
//  CountryInfo.m
//  CountryApp
//
//  Created by Sander on 29.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryInfo.h"

#define kContinent @"Continent"
#define kCountry @"Country"
#define kCapital @"Capital"
#define kPopulation @"Population"
#define kCountryInfoObj @"CountryInfoObj"

@implementation CountryInfo

+ (CountryInfo*)countryInfoWithContinent:(NSString*)continent country:(NSString*)country capital:(NSString*)capital population:(NSNumber*)population
{
    CountryInfo *countryInfo   = [[CountryInfo alloc] init];
    countryInfo.continentTitle = continent;
    countryInfo.countryTitle   = country;
    countryInfo.capitalTitle   = capital;
    countryInfo.population     = population;
    
    return countryInfo;
}
   
- (NSString*)additionalInfo
{
    NSString *str;
    if (self.population) {
        str = [NSString stringWithFormat:@"%@ (%@)", self.capitalTitle, self.population];
    } else {
        str = [NSString stringWithFormat:@"%@", self.capitalTitle];
    }
    return str;
}

@end
