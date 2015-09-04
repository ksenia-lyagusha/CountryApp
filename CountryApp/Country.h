//
//  Country.h
//  CountryApp
//
//  Created by Оксана on 29.08.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

- (NSString*)additionalInfo;

@property (nonatomic, retain) NSString * continent;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * capital;
@property (nonatomic, retain) NSNumber * population;

+ (Country*)countryInfoWithContinent:(NSString*)continent country:(NSString*)country capital:(NSString*)capital population:(NSNumber*)population;

@end
