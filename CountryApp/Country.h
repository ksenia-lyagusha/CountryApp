//
//  Country.h
//  
//
//  Created by Оксана on 10.09.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Continent;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * capital;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * population;
@property (nonatomic, retain) Continent *continent;

- (NSString*)additionalInfo;

/**
 *  Creates a new Country object in DB
 *
 *  @param continent  id, either can receive type Continent, if Continent already exist or NSString contninentTitle, if need to fetch object from DB
 *  @param country    NSString name of the country
 *  @param capital    NSString name of the capital
 *  @param population NSNumber number of population
 *
 *  @return Country object
 */
+ (Country*)countryWithContinentOrContinentTitle:(id)continent country:(NSString *)country capital:(NSString *)capital population:(NSNumber *)population;
@end
