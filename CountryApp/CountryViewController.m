//
//  CountryViewController.m
//  CountryApp
//
//  Created by Sander on 29.03.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryViewController.h"
#import "CountryModel.h"

@interface CountryViewController ()
@property CountryModel *countryModel;

@end

@implementation CountryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Countries";
    self.countryModel = [[CountryModel alloc] init];

}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countryModel numberOfContinents];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str = [self.countryModel titleOfContinentForIndex:section];
    return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectiontableView
{
    NSString *continent = [self.countryModel titleOfContinentForIndex:sectiontableView];
    return [self.countryModel countOfCountriesInContinent:continent];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *continent = [self.countryModel titleOfContinentForIndex:indexPath.section];
    CountryInfo *obj = [self.countryModel countryInfoObjectAtContinent:continent atIndex:indexPath.row];
    cell.textLabel.text = obj.countryTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@)", obj.capitalTitle, obj.population];
    return cell;
}

#pragma mark - Delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showAlert:self.countryModel.countries[indexPath.row]];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewCellAccessoryType accessory;
    switch (indexPath.row) {
        case 0:
            accessory = UITableViewCellAccessoryDetailButton;
            break;
        case 1:
            accessory = UITableViewCellAccessoryDetailDisclosureButton;
            break;
        case 2:
            accessory = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            accessory = UITableViewCellAccessoryCheckmark;
            break;
        default:
            break;
    }
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = accessory;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark - Helpers

- (void)showAlert:(NSString*)country
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                    message:[NSString stringWithFormat:@"You selected %@",country]
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cheel out"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}



@end