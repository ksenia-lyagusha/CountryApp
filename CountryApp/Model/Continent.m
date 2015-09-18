//
//  Continent.m
//  
//
//  Created by Оксана on 10.09.15.
//
//

#import "Continent.h"
#import "Country.h"
#import "MagicalRecord.h"

@implementation Continent

@dynamic title;
@dynamic country;


+ (Continent *)continentWithTitle:(NSString *)continent
{
    Continent *obj = [Continent MR_createEntity];
    obj.title      = continent;
    return obj;
}

@end
