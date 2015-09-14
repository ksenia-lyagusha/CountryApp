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
+ (Country*)countryWithContinent:(id)continent country:(NSString *)country capital:(NSString *)capital population:(NSNumber *)population;
@end
