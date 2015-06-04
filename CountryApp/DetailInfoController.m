//
//  DetailInfoController.m
//  CountryApp
//
//  Created by Sander on 20.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "DetailInfoController.h"

@interface DetailInfoController ()

@end

@implementation DetailInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    

    self.title = self.obj.countryTitle;
    self.continent.text = self.obj.continentTitle;
    self.country.text = self.obj.countryTitle;
    self.capital.text = self.obj.capitalTitle;
    self.population.text = [self.obj.population stringValue];
}

@end