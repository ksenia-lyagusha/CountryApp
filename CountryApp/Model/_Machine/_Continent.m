// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Continent.m instead.

#import "_Continent.h"

const struct ContinentAttributes ContinentAttributes = {
	.title = @"title",
};

const struct ContinentRelationships ContinentRelationships = {
	.countries = @"countries",
};

@implementation ContinentID
@end

@implementation _Continent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Continent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Continent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Continent" inManagedObjectContext:moc_];
}

- (ContinentID*)objectID {
	return (ContinentID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic title;

@dynamic countries;

- (NSMutableSet*)countriesSet {
	[self willAccessValueForKey:@"countries"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"countries"];

	[self didAccessValueForKey:@"countries"];
	return result;
}

@end

