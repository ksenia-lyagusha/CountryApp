//
//  CountryModel.m
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryModel.h"

@interface CountryModel()
@property NSArray *continents;

@end

@implementation CountryModel

- (id)init
{
    self = [super init];
    if (self) {
        [self fillArray];
    }
    return self;
}

- (void)fillArray
{
    self.continents = @[ @{@"continent" : @"Europe",
                             @"country" : @"Ukraine",
                             @"capital" : @"Kyiv"}
                         ,
                         @{@"continent" : @"Asia",
                             @"country" : @"China",
                             @"capital" : @"Beijing"}
                         ,
                         @{@"continent" : @"Europe",
                             @"country" : @"Poland",
                             @"capital" : @"Warsaw"}
                         ,
                         @{@"continent" : @"Europe",
                             @"country" : @"Austria",
                             @"capital" : @"Vienna"}
                         ,
                         @{@"continent" : @"Asia",
                             @"country" : @"South Korea",
                             @"capital" : @"Seoul"}
                        ];
}

- (NSInteger)numberOfContinents
{
    NSMutableSet *continent = [NSMutableSet set];
    for (NSDictionary *continentsTitle in self.continents) {
       NSString *continentStr = [continentsTitle objectForKey:@"continent"];
       [continent addObject:continentStr];
    }
    return [continent count];
}

- (NSInteger)countOfCountriesInContinent:(NSString*)titleOfContinent
{
    NSInteger countOfCountries = 0;
    for (NSDictionary *countryInfo in self.continents) {
        if ([titleOfContinent isEqualToString:countryInfo[@"continent"]]) {
            countOfCountries++;
        }
    }
    return countOfCountries;
}

- (NSString*)getNameOfCountryForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index
{
    NSInteger count = 0;
    NSString *countryTitle;
    for (NSDictionary *countryInfo in self.continents) {
        if ([titleOfContinent isEqualToString:[countryInfo objectForKey:@"continent"]]) {
            if (index == count) {
                countryTitle = [countryInfo objectForKey:@"country"];
            }
            count++;
        }
    }
    return countryTitle;
}

- (NSString*)getNameOfCapitalForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index
{
    NSInteger currentElem = 0;
    NSString *capitalTitle;
    for (NSDictionary *countryInfo in self.continents) {
        if ([titleOfContinent isEqualToString:[countryInfo objectForKey:@"continent"]]) {
            if (index == currentElem) {
                capitalTitle = [countryInfo objectForKey:@"capital"];
            }
            currentElem++;
        }
    }
    return capitalTitle;

}

- (NSString*)titleOfContinentForIndex:(NSInteger)index
{
    NSMutableSet *continentSet = [NSMutableSet set];
    for (NSDictionary *countryInfo in self.continents) {
        [continentSet addObject:[countryInfo objectForKey:@"continent"]];
    }
    NSArray *continentArr = [continentSet allObjects];
    
    return [continentArr objectAtIndex:index];
}







@end