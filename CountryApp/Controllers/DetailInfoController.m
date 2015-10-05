//
//  DetailInfoController.m
//  CountryApp
//
//  Created by Sander on 20.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "DetailInfoController.h"
#import "MagicalRecord.h"
#import "CountryViewController.h"
#import "Continent.h"
#import "MapViewController.h"
#import "CountryAppModel.h"
#import "AddInfoController.h"

@interface DetailInfoController ()

@property (weak, nonatomic) IBOutlet UILabel *continent;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *population;

@property (weak, nonatomic) IBOutlet UIButton *editButon;

@end

@implementation DetailInfoController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.title           = self.obj.title;
    NSString *code       = [CountryAppModel searchCountryCode:self.title];
    self.country.text    = code ? [NSString stringWithFormat:@"%@ (%@)", self.obj.title, [code uppercaseString]] : self.obj.title;
    self.capital.text    = self.obj.capital;
    self.continent.text  = self.obj.continent.title;
    self.population.text = [NSString stringWithFormat:@"%@", self.obj.population ?: @""];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MapSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
    
        MapViewController *mapViewController = (MapViewController*)navigationController.topViewController;
        mapViewController.country = self.obj;
        
    } else if ([segue.identifier isEqualToString:@"AddInfoSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddInfoController *addInfo = (AddInfoController*)navigationController.topViewController;
        addInfo.countryObj = self.obj;
    }
    
}
@end
