//
//  CountryAppModel.m
//  CountryApp
//
//  Created by Оксана on 04.09.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryAppModel.h"
#import "Country.h"
#import "MagicalRecord.h"

#define kIsEnter @"Counter"

@interface CountryAppModel ()
@property (strong, nonatomic) NSArray *continents;

@end

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:kIsEnter];
    return  allValues;
}

- (void)readingData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isSecond = [defaults boolForKey:kIsEnter];
    if (!isSecond) {
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"CountriesAndCapitals" ofType:@"plist"];
        self.continents = [NSMutableArray arrayWithContentsOfFile:defaultPath];
        self.continents = [self fillArray];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    }
}

@end
