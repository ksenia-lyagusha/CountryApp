//
//  CountryModel.h
//  CountryApp
//
//  Created by Sander on 01.04.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryModel : NSObject
@property NSArray *countries;
@property NSArray *capitals;
- (void)fillArray;

@end
