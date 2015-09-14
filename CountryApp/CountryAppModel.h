//
//  CountryAppModel.h
//  CountryApp
//
//  Created by Оксана on 04.09.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryAppModel : NSObject

+ (CountryAppModel*)sharedInstance;
- (void)readingData;

@end
