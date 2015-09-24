
//  FlagLoading.m
//  CountryApp
//
//  Created by Оксана on 15.09.15.
//  Copyright (c) 2015 Оксана. All rights reserved.
//

#import "FlagLoading.h"

@interface FlagLoading ()

@property NSMutableDictionary *blocks;
@property NSMutableDictionary *datas;

@end

@implementation FlagLoading

// singleTon
+ (FlagLoading*)sharedInstance
{
    static FlagLoading *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FlagLoading alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas  = [NSMutableDictionary dictionary];
        self.blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)sendRequest:(NSString *)siteLink withImageHandler:(void (^)(UIImage *))imageBlock
{
    NSURLSession *url = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                      delegate:self
                                                 delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [url dataTaskWithURL:[NSURL URLWithString:siteLink]];
    [dataTask resume];

    [self.blocks setObject:imageBlock forKey:dataTask];
}

- (NSString *)formatSiteLink:(NSString *)link
{
//    return @"https://www.wonderplugin.com/wp-content/plugins/wonderplugin-lightbox/images/demo-image0.jpg";
    return [NSString stringWithFormat:@"https://raw.githubusercontent.com/hjnilsson/country-flags/master/png250px/%@.png", link];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *receivedData = [self.datas objectForKey:dataTask];
    if (!receivedData) {
        receivedData = [NSMutableData data];
    }
    [receivedData appendData:data];
    
    [self.datas setObject:receivedData forKey:dataTask];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)errorURLSession
{
    NSData *data = [self.datas objectForKey:task];
    UIImage *img = [UIImage imageWithData:data];
    void (^imageHandler)(UIImage*) = [self.blocks objectForKey:task];
    imageHandler(img);
    [self.datas removeObjectForKey:task];
    [self.blocks removeObjectForKey:task];
    if (errorURLSession) {
        NSLog(@"%@", errorURLSession.description);
    }
}

@end
