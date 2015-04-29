//
//  CountryModel.m
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryModel.h"
#import <CoreGraphics/CoreGraphics.h>
#import "CountryInfo.h"

@interface CountryModel()
@property NSArray *continents;

@end

@implementation CountryModel

- (id)init
{
    self = [super init];
    if (self) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"CountriesAndCapitals.plist" ofType:nil];
        self.continents = [NSArray arrayWithContentsOfFile:defaultPath];
//            self.continents = allValues;
        self.continents = [self fillArray];
    }
    return self;
}  

- (NSArray*)fillArray
{
    NSMutableArray *allValues = [NSMutableArray array];

    for (NSDictionary *dict in self.continents){
        CountryInfo *informationOfCountry = [[CountryInfo alloc] init];
        informationOfCountry.continentTitle = [dict objectForKey:@"continent"];
        informationOfCountry.countryTitle = [dict objectForKey:@"country"];
        informationOfCountry.capitalTitle = [dict objectForKey:@"capital"];
        informationOfCountry.population = [dict objectForKey:@"population"];
        [allValues addObject:informationOfCountry];
    }
    return allValues;
}

#pragma mark - API

- (NSInteger)numberOfContinents
{
    NSArray *continent = [self allContinents];
    return [continent count];
}

- (NSInteger)countOfCountriesInContinent:(NSString*)titleOfContinent
{
    NSInteger countOfCountries = [[self allCountriesInContinent:titleOfContinent] count];
    return countOfCountries;
}


- (NSString*)getNameOfCountryForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index
{
    NSArray *countryArray = [self allCountriesInContinent:titleOfContinent];
    countryArray = [countryArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    return [countryArray objectAtIndex:index];
}

- (NSString*)getNameOfCapitalForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index
{
    NSString *country = [self getNameOfCountryForContinent:titleOfContinent atIndex:index];
    NSString *capital;
    for (CountryInfo *countryInfo in self.continents) {
        if ([country isEqualToString:countryInfo.countryTitle]){
            capital = countryInfo.capitalTitle;
            break;
        }
    }
    return capital;
}

- (NSString*)titleOfContinentForIndex:(NSInteger)index
{
    NSArray *continent  = [[self allContinents] sortedArrayUsingSelector:@selector(compare:)]/*reverseObjectEnumerator] allObjects]*/;
    return [continent objectAtIndex:index];
}

- (NSNumber*)getPopulationOfCapitalForContinent:(NSString*)titleOfContinent atIndex:(NSInteger)index
{
    NSString *country = [self getNameOfCountryForContinent:titleOfContinent atIndex:index];
    NSNumber *populationInCapital;
    for (CountryInfo *countryInfo in self.continents) {
        if ([country isEqualToString:countryInfo.countryTitle]){
            populationInCapital = countryInfo.population;
        }
    }
    return populationInCapital;
}

#pragma mark - Private methods

- (NSArray*)allCountriesInContinent:(NSString*)titleOfContinent
{
    NSMutableArray *countryArray = [NSMutableArray array];
    
    for (CountryInfo *countryInfo in self.continents) {
        if ([titleOfContinent isEqualToString:countryInfo.continentTitle]) {
            [countryArray addObject:countryInfo.countryTitle];
        }
    }
    return countryArray;
}

- (NSArray*)allContinents
{
    NSMutableSet *continentSet = [NSMutableSet set];
    for (CountryInfo *countryInfo in self.continents) {
        [continentSet addObject:countryInfo.continentTitle];
    }
    NSArray *continentArr = [continentSet allObjects];
    return continentArr;
}

@end