// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Continent.h instead.

@import CoreData;

extern const struct ContinentAttributes {
	__unsafe_unretained NSString *title;
} ContinentAttributes;

extern const struct ContinentRelationships {
	__unsafe_unretained NSString *countries;
} ContinentRelationships;

@class Country;

@interface ContinentID : NSManagedObjectID {}
@end

@interface _Continent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ContinentID* objectID;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *countries;

- (NSMutableSet*)countriesSet;

@end

@interface _Continent (CountriesCoreDataGeneratedAccessors)
- (void)addCountries:(NSSet*)value_;
- (void)removeCountries:(NSSet*)value_;
- (void)addCountriesObject:(Country*)value_;
- (void)removeCountriesObject:(Country*)value_;

@end

@interface _Continent (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveCountries;
- (void)setPrimitiveCountries:(NSMutableSet*)value;

@end
