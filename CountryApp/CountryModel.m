//
//  CountryModel.m
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryModel.h"
#import <CoreGraphics/CoreGraphics.h>

#define kAllCountries @"AllCountries"
#define kIsEnter @"Counter"
@interface CountryModel()
@property NSMutableArray *continents;

@end

@implementation CountryModel

- (id)init
{
    self = [super init];
    if (self) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"CountriesAndCapitals.plist" ofType:nil];
        self.continents = [NSMutableArray arrayWithContentsOfFile:defaultPath];
        
        self.continents = [self fillArray];
        
        [self readingAndDecoding];

    }
    return self;
}

- (NSMutableArray*)fillArray
{
    NSMutableArray *allValues = [NSMutableArray array];
    for (NSDictionary *informationOfCountry in self.continents) {
        CountryInfo *obj = [CountryInfo countryInfoWithContinent:informationOfCountry[@"continent"]
                                                         country:informationOfCountry[@"country"]
                                                         capital:informationOfCountry[@"capital"]
                                                      population:informationOfCountry[@"population"]];
        [allValues addObject:obj];
    }
    return  allValues;
}

+ (CountryModel*)sharedInstance                     /*singleTon*/
{
    static CountryModel *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CountryModel alloc] init];
    });
    return _sharedInstance;
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

- (NSString*)titleOfContinentForIndex:(NSInteger)index
{
    NSArray *continent  = [[self allContinents] sortedArrayUsingSelector:@selector(compare:)]/*reverseObjectEnumerator] allObjects]*/;
    return [continent objectAtIndex:index];
}

- (CountryInfo*)countryInfoObj:(NSIndexPath*)indexPath
{
    NSString *str = [self titleOfContinentForIndex:indexPath.section];
    NSArray *arr = [self allCountriesInContinent:str];
    
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(CountryInfo *obj1, CountryInfo *obj2) {
        return [obj1.countryTitle compare:obj2.countryTitle];
    }];
    
    return [arr objectAtIndex:indexPath.row];
}

- (void)deleteObjectFromList:(NSIndexPath*)indexPath
{
    CountryInfo *obj = [self countryInfoObj:indexPath];
    [self.continents removeObject:obj];
    [self savingAndEncoding];
}

- (void)addNewObject:(CountryInfo*)countryInfo
{
    [self.continents addObject:countryInfo];
    [self savingAndEncoding];
}

#pragma mark - Private methods

- (NSArray*)allCountriesInContinent:(NSString*)titleOfContinent
{
    NSMutableArray *countryArray = [NSMutableArray array];
    
    for (CountryInfo *countryInfo in self.continents) {
        if ([titleOfContinent isEqualToString:countryInfo.continentTitle]) {
            [countryArray addObject:countryInfo];
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
- (void)readingAndDecoding
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isSecond = [defaults boolForKey:kIsEnter];
    if (isSecond) {
        NSData *obj = [defaults dataForKey:kAllCountries];
        self.continents = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        
    }
}


- (void)savingAndEncoding
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.self.continents] forKey:kAllCountries];
    [defaults setBool:YES forKey:kIsEnter];
}

@end

