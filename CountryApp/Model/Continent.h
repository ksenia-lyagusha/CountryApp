//
//  Continent.h
//  
//
//  Created by Оксана on 10.09.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Country;

@interface Continent : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet    * country;

+ (Continent*)continentWithTitle:(NSString *)continent;

@end

@interface Continent (CoreDataGeneratedAccessors)

- (void)addCountryObject:(Country *)value;
- (void)removeCountryObject:(Country *)value;
- (void)addCountry:(NSSet *)values;
- (void)removeCountry:(NSSet *)values;

@end
