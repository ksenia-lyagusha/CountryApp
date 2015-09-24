//
//  CountryAppModel.m
//  CountryApp
//
//  Created by Оксана on 04.09.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryAppModel.h"
#import "Country.h"
#import "Continent.h"
#import "MagicalRecord.h"

#define kIsEnter @"Counter"

@implementation CountryAppModel

 // singleTon
+ (CountryAppModel*)sharedInstance
{
    static CountryAppModel *_sharedInstance = nil;
    // dispatch_once_t type is long
    static dispatch_once_t oncePredicate;
    // & means getting adress of primitive
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CountryAppModel alloc] init];
    });
    return _sharedInstance;
}

- (void)addCountryObjects
{
    NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"CountriesAndCapitals" ofType:@"plist"];
    NSArray *countryObj = [NSMutableArray arrayWithContentsOfFile:defaultPath];
    for (NSDictionary *informationOfCountry in countryObj) {
      
        Country *country = [Country MR_createEntity];
        
       [country countryWithContinentOrContinentTitle:informationOfCountry[@"continent"]
                                             country:informationOfCountry[@"country"]
                                             capital:informationOfCountry[@"capital"]
                                          population:informationOfCountry[@"population"]];
        [country downloadImage];
    }
}

- (void)addContinentObjects
{
    NSString *defaultContinents = [[NSBundle mainBundle] pathForResource:@"Continents" ofType:@"plist"];
    NSArray *continentObj = [NSMutableArray arrayWithContentsOfFile:defaultContinents];
    for (NSString *continent in continentObj) {
        
       [Continent continentWithTitle:continent];
    }
}

- (void)readData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isSecond = [defaults boolForKey:kIsEnter];
    if (!isSecond) {
        [self addContinentObjects];
        [self addCountryObjects];
        
        [defaults setBool:YES forKey:kIsEnter];
    }
}

+ (NSString *)searchCountryCode:(NSString *)countryTitle
{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in countryCodes)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents:[NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode]];
        NSString *formattedCode = [[identifier stringByReplacingOccurrencesOfString:@"_" withString:@""] lowercaseString];
        NSString *country = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_UK"] displayNameForKey:NSLocaleIdentifier value:identifier];
        
        if ([country isEqualToString:countryTitle]) {
            return formattedCode;
        }
        
    }
    return nil;
}

@end
