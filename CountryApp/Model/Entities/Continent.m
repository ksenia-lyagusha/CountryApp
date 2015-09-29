
#import "Continent.h"
#import "Country.h"
#import "MagicalRecord.h"

@interface Continent ()

@end

@implementation Continent

+ (Continent *)continentWithTitle:(NSString *)continent
{
    Continent *obj = [Continent MR_createEntity];
    obj.title      = continent;
    return obj;
}


@end
