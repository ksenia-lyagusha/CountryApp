//
//  CountryModel.m
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryModel.h"

@interface CountryModel()
@property NSArray *countries;
@property NSArray *capitals;
@property NSArray *array;
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
    self.countries = @[@"Ukraine", @"Poland", @"Austria", @"China", @"South Korea"];
    self.capitals = @[@"Kyiv", @"Warsaw", @"Vienna", @"Beijing", @"Seoul"];
}

- (NSInteger)countOfCountries
{
    return self.countries.count;
}

- (NSString*)getNameOfCountryForIndex:(NSInteger)numberOfRow
{
    return [self.countries objectAtIndex:numberOfRow];
}

- (NSString*)getNameOfCapitalForIndex:(NSInteger)numberOfRow
{
    return [self.capitals objectAtIndex:numberOfRow];
}

@end