
#import "_Country.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>



@interface Country : _Country {}
/**
 *  Creates a new Country object in DB
 *
 *  @param continent  id, either can receive type Continent, if Continent already exist or NSString contninentTitle, if need to fetch object from DB
 *  @param country    NSString name of the country
 *  @param capital    NSString name of the capital
 *  @param population NSNumber number of population
 *  @param longitude  NSNumber longitude of capital of country
 *  @param latitude   NSNumber latitide of capital of country
 *  @return Country object
 */
- (Country*)countryWithContinentOrContinentTitle:(id)continent
                                         country:(NSString *)country
                                         capital:(NSString *)capital
                                      population:(NSNumber *)population;


- (NSString*)additionalInfo;

- (void)addImageObject:(UIImage *)image;
- (void)downloadImage;
- (void)addLongitude:(double)longitude andLatitude:(double)latitude;

@end
