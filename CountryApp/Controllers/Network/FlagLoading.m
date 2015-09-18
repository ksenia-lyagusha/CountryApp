//
//  FlagLoading.m
//  CountryApp
//
//  Created by Оксана on 15.09.15.
//  Copyright (c) 2015 Оксана. All rights reserved.
//

#import "FlagLoading.h"

@interface FlagLoading ()
@property (copy) void (^imageBlock)(UIImage*);
@property NSMutableData *receivedData;

@end

@implementation FlagLoading

- (void)sendRequest:(NSString *)siteLink withImageHandler:(void (^)(UIImage *))image
{
    NSURLSession *url = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                      delegate:self
                                                 delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [url dataTaskWithURL:[NSURL URLWithString:siteLink]];
    [dataTask resume];
    
    self.receivedData = [[NSMutableData alloc] init];
    
    self.imageBlock   = image;
}

- (NSString *)formatSiteLink:(NSString *)link
{
    return [NSString stringWithFormat:@"https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/%@.png", link];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)errorURLSession
{
    if (self.imageBlock) {
        UIImage *img = [UIImage imageWithData:self.receivedData];
        self.imageBlock(img);
    }
}

@end
