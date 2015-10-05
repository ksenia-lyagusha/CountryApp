

#import "Country.h"
#import "Country.h"
#import "Continent.h"
#import "MagicalRecord.h"
#import "CountryAppModel.h"
#import "FlagLoading.h"
#import <CoreLocation/CLAvailability.h>

@interface Country ()

@end

@implementation Country

- (Country*)countryWithContinentOrContinentTitle:(id)continent country:(NSString *)country capital:(NSString *)capital population:(NSNumber *)population
{
    
    self.continent  = [continent isMemberOfClass:([Continent class])] ? continent : [Continent MR_findFirstByAttribute:@"title" withValue:continent];
    self.title      = country;
    self.capital    = capital;
    self.population = population;
    
    return self;
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

- (void)addImageObject:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    self.image        = imageData;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)downloadImage
{
    NSString *code = [CountryAppModel searchCountryCode:self.title];
    FlagLoading *flagLoading = [FlagLoading sharedInstance];
    NSString *link = [flagLoading formatSiteLink:code];
    [flagLoading sendRequest:link withImageHandler:^(UIImage * image) {
        [self addImageObject:image];
    }];
}

- (void)addLongitude:(double)longitude andLatitude:(double)latitude
{
    self.longitudeValue = longitude;
    self.latitudeValue  = latitude;
}
@end
