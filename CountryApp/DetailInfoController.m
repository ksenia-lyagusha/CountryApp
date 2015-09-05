//
//  DetailInfoController.m
//  CountryApp
//
//  Created by Sander on 20.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "DetailInfoController.h"
#import <NSManagedObject+MagicalFinders.h>
#import "CountryViewController.h"

@interface DetailInfoController ()

@property (weak, nonatomic) IBOutlet UILabel *continent;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *capital;
@property (weak, nonatomic) IBOutlet UILabel *population;

@end

@implementation DetailInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = self.obj.country;
    self.continent.text = self.obj.continent;
    self.country.text = self.obj.country;
    self.capital.text = self.obj.capital;
    self.population.text = [NSString stringWithFormat:@"%@", self.obj.population];
    
}

@end
