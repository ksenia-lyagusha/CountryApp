//
//  FlagLoading.h
//  CountryApp
//
//  Created by Оксана on 15.09.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlagLoading : NSObject <NSURLSessionDataDelegate>

- (void)sendRequest:(NSString *)siteLink withImageHandler:(void(^)(UIImage*))image;
- (NSString *)formatSiteLink:(NSString *)link;
@end
