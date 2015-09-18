//
//  Country.h
//  
//
//  Created by Оксана on 16.09.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@class Continent;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSString  * capital;
@property (nonatomic, retain) NSNumber  * population;
@property (nonatomic, retain) NSString  * title;
@property (nonatomic, retain) NSData    * image;
@property (nonatomic, retain) Continent *continent;

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
- (Country*)countryWithContinentOrContinentTitle:(id)continent country:(NSString *)country capital:(NSString *)capital population:(NSNumber *)population;

- (NSString*)additionalInfo;

- (void)addImageObject:(UIImage *)image;
- (void)downloadImage;
@end
