//
//  CountryInfo.h
//  CountryApp
//
//  Created by Sander on 29.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryInfo : NSObject
@property NSString *continentTitle;
@property NSString *countryTitle;
@property NSString *capitalTitle;
@property NSNumber *population;

+ (CountryInfo*)countryInfoWithContinent:(NSString*)continent country:(NSString*)country capital:(NSString*)capital population:(NSNumber*)population;
- (NSString*)additionalInfo;

@end
