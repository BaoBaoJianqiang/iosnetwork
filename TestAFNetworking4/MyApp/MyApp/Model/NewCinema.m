// JSON iOS Class Generator
// Written by Bruce Bao

#import "NewCinema.h"
#import "ObjectMapping.h"

@implementation NewCinema

@synthesize cinemaId;
@synthesize cinemaName;

- (ObjectMapping *)objectMapping {
    ObjectMapping *mapping = [ObjectMapping mappingForClass:[NewCinema class]];
    [mapping converEntityFromJsonToEntity:@"result" to:@"NewCinema" withClass: @"NewCinema"];
    [mapping converEntityFromJsonToEntity:@"cinemaId" to:@"cinemaId" withClass: @"NSString"];
    [mapping converEntityFromJsonToEntity:@"cinemaName" to:@"cinemaName" withClass: @"NSString"];
    return mapping;
}
@end
