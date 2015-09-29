// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Country.h instead.

@import CoreData;

extern const struct CountryAttributes {
	__unsafe_unretained NSString *capital;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *population;
	__unsafe_unretained NSString *title;
} CountryAttributes;

extern const struct CountryRelationships {
	__unsafe_unretained NSString *continent;
} CountryRelationships;

@class Continent;

@interface CountryID : NSManagedObjectID {}
@end

@interface _Country : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CountryID* objectID;

@property (nonatomic, strong) NSString* capital;

//- (BOOL)validateCapital:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* population;

@property (atomic) int64_t populationValue;
- (int64_t)populationValue;
- (void)setPopulationValue:(int64_t)value_;

//- (BOOL)validatePopulation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Continent *continent;

//- (BOOL)validateContinent:(id*)value_ error:(NSError**)error_;

@end

@interface _Country (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCapital;
- (void)setPrimitiveCapital:(NSString*)value;

- (NSData*)primitiveImage;
- (void)setPrimitiveImage:(NSData*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSNumber*)primitivePopulation;
- (void)setPrimitivePopulation:(NSNumber*)value;

- (int64_t)primitivePopulationValue;
- (void)setPrimitivePopulationValue:(int64_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (Continent*)primitiveContinent;
- (void)setPrimitiveContinent:(Continent*)value;

@end
