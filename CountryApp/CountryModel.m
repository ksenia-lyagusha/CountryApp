//
//  CountryModel.m
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryModel.h"
#import <CoreGraphics/CoreGraphics.h>
#import <NSManagedObjectContext+MagicalSaves.h>
#import <MagicalRecord+ShorthandMethods.h>
#import <NSManagedObject+MagicalRecord.h>

#import "Country.h"
#define kIsEnter @"Counter"

@interface CountryModel()


@property NSMutableArray *continents;
@property (nonatomic, strong) Country *country;

@end

@implementation CountryModel



- (id)init
{
    self = [super init];
    if (self) {
        [self readingData];
    }
    return self;
}

- (NSMutableArray*)fillArray
{
   
    NSMutableArray *allValues = [NSMutableArray array];
    for (NSDictionary *informationOfCountry in self.continents) {
        Country *obj = [Country countryInfoWithContinent:informationOfCountry[@"continent"]
                                                 country:informationOfCountry[@"country"]
                                                 capital:informationOfCountry[@"capital"]
                                              population:informationOfCountry[@"population"]];
        [allValues addObject:obj];
    }
    [self savingData];
    return  allValues;
}

+ (CountryModel*)sharedInstance                     /*singleTon*/
{
    static CountryModel *_sharedInstance = nil;
    // dispatch_once_t type is long
    static dispatch_once_t oncePredicate;
    // & means getting adress of primitive
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CountryModel alloc] init];
    });
    return _sharedInstance;
}
#pragma mark - API

- (NSInteger)numberOfContinents
{
//    NSArray *continent = [self allContinents];
//    return [continent count];
    return [[[self allContinents] sections] count];
}

- (NSInteger)countOfCountriesInContinent:(NSString*)titleOfContinent
{
//    NSInteger countOfCountries = [[self allCountriesInContinent:titleOfContinent] count];
//    return countOfCountries;
    return [[[self allCountriesInContinent:titleOfContinent] sections] count];
}

- (NSString*)titleOfContinentForIndex:(NSInteger)index
{
//    NSArray *continent  = [[self allContinents] sortedArrayUsingSelector:@selector(compare:)]/*reverseObjectEnumerator] allObjects]*/;
//    return [continent objectAtIndex:index];
    NSArray *continent = [[self allContinents] sections]; //sortedArrayUsingSelector:@selector(compare:)];
    NSString *str = [[continent objectAtIndex:index] name];
    return str;
}

- (Country*)countryInfoObj:(NSIndexPath*)indexPath
{
//    NSString *str = [self titleOfContinentForIndex:indexPath.section];
//    NSArray *arr = [self allCountriesInContinent:str];
    
    NSString *str = [self titleOfContinentForIndex:indexPath.section];
    NSArray *arr = [[self allCountriesInContinent:str] sections];
    
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(Country *obj1, Country *obj2) {
        return [obj1.country compare:obj2.country];
    }];
    
    return [arr objectAtIndex:indexPath.row];
}

- (void)deleteObjectFromList:(NSIndexPath*)indexPath
{
    self.country = [self countryInfoObj:indexPath];
    [self.country MR_deleteEntity];
    [self savingData];
    [self.continents removeObject:self.country];
  
}

- (void)addNewObject:(Country*)countryInfo
{
    [self.continents addObject:countryInfo];
    [self savingData];
}

#pragma mark - Private methods

- (NSFetchedResultsController*)allCountriesInContinent:(NSString*)titleOfContinent
{
//    NSMutableArray *countryArray = [NSMutableArray array];
//    
//    for (Country *countryInfo in self.continents) {
//        if ([titleOfContinent isEqualToString:countryInfo.continent]) {
//            [countryArray addObject:countryInfo];
//        }
//    }
//    return countryArray;
//    return [Country MR_fetchAllSortedBy:@"continent" ascending:YES withPredicate:nil groupBy:@"continent" delegate:self inContext:[NSManagedObjectContext MR_defaultContext]];
    return [Country MR_fetchAllGroupedBy:@"country" withPredicate:nil sortedBy:@"continent" ascending:YES delegate:self];
}

- (NSFetchedResultsController*)allContinents
{
//    NSMutableSet *continentSet = [NSMutableSet set];
//    for (Country *countryInfo in self.continents) {
//        [continentSet addObject:countryInfo.continent];
//    }
//    NSArray *continentArr = [continentSet allObjects];
    
    return [Country MR_fetchAllGroupedBy:@"continent" withPredicate:nil sortedBy:@"country" ascending:YES delegate:self];
}

- (void)readingData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isSecond = [defaults boolForKey:kIsEnter];
    if (isSecond) {
        self.continents = [[Country MR_findAll] mutableCopy];
        
    } else {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"CountriesAndCapitals" ofType:@"plist"];
        self.continents = [NSMutableArray arrayWithContentsOfFile:defaultPath];
        self.continents = [self fillArray];
    }
}

- (void)savingData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:kIsEnter];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end

