//
//  Country.m
//  CountryApp
//
//  Created by Оксана on 29.08.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "Country.h"
#import "MagicalRecord.h"

@implementation Country

@dynamic continent;
@dynamic country;
@dynamic capital;
@dynamic population;

- (NSString*)additionalInfo
{
    NSString *str;
    if (self.population) {
        str = [NSString stringWithFormat:@"%@ (%@)", self.capital, self.population];
    } else {
        str = [NSString stringWithFormat:@"%@", self.capital];
    }
    return str;
}

+ (Country*)countryInfoWithContinent:(NSString*)continent country:(NSString*)country capital:(NSString*)capital population:(NSNumber*)population
{
    Country *countryInfo   = [Country MR_createEntity];
    countryInfo.continent  = continent;
    countryInfo.country    = country;
    countryInfo.capital    = capital;
    countryInfo.population = population;
    
    return countryInfo;
}
@end
