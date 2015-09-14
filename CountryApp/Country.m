//
//  Country.m
//  
//
//  Created by Оксана on 10.09.15.
//
//

#import "Country.h"
#import "Continent.h"
#import "MagicalRecord.h"

@implementation Country

@dynamic capital;
@dynamic title;
@dynamic population;
@dynamic continent;

+ (Country*)countryWithContinentOrContinentTitle:(id)continent country:(NSString *)country capital:(NSString *)capital population:(NSNumber *)population
{
    Country *countryInfo   = [Country MR_createEntity];
    countryInfo.continent  = [continent isMemberOfClass:([Continent class])] ? continent : [Continent MR_findFirstByAttribute:@"title" withValue:continent];
    countryInfo.title      = country;
    countryInfo.capital    = capital;
    countryInfo.population = population;
    
    return countryInfo;
}

- (NSString*)additionalInfo
{
    NSString *str;
    if (self.population) {
        str = [NSString stringWithFormat:@"%@ (%@)", self.capital, self.population];
        
    } else {
        str = [NSString stringWithFormat:@"%@", self.capital];
    }
    return str;
}


@end
