// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.m instead.

#import "_Country.h"

const struct CountryAttributes CountryAttributes = {
	.capital = @"capital",
	.image = @"image",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.population = @"population",
	.title = @"title",
};

const struct CountryRelationships CountryRelationships = {
	.continent = @"continent",
};

@implementation CountryID
@end

@implementation _Country

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Country";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Country" inManagedObjectContext:moc_];
}

- (CountryID*)objectID {
	return (CountryID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"populationValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"population"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic capital;

@dynamic image;

@dynamic latitude;

- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:@(value_)];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:@(value_)];
}

@dynamic longitude;

- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:@(value_)];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:@(value_)];
}

@dynamic population;

- (int64_t)populationValue {
	NSNumber *result = [self population];
	return [result longLongValue];
}

- (void)setPopulationValue:(int64_t)value_ {
	[self setPopulation:@(value_)];
}

- (int64_t)primitivePopulationValue {
	NSNumber *result = [self primitivePopulation];
	return [result longLongValue];
}

- (void)setPrimitivePopulationValue:(int64_t)value_ {
	[self setPrimitivePopulation:@(value_)];
}

@dynamic title;

@dynamic continent;

@end

