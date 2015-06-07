//
//  CountryViewController.m
//  CountryApp
//
//  Created by Sander on 29.03.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "CountryViewController.h"
#import "CountryModel.h"
#import "DetailInfoController.h"
#import "AddInfoController.h"

@interface CountryViewController ()
@property CountryModel *countryModel;

@end

@implementation CountryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Countries";
    self.countryModel = [[CountryModel alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(createNewObject)];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
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
    CountryInfo *obj = [self.countryModel countryInfoObj:indexPath];
    cell.textLabel.text = obj.countryTitle;
    cell.detailTextLabel.text = [obj additionalInfo];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView beginUpdates];
         NSString *continent = [self.countryModel titleOfContinentForIndex:indexPath.section];
        [self.countryModel deleteObjectFromList:indexPath];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
        if ([self.countryModel countOfCountriesInContinent:continent] == 0) {
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        }

        [tableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
 
#pragma mark - Delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self showAlert:self.countryModel.countries[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailInfoController *detailInfo = [[DetailInfoController alloc] init];
    [self.navigationController pushViewController:detailInfo animated:YES];// detailViewController
    detailInfo.obj = [self.countryModel countryInfoObj:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Helpers

- (void)showAlert:(NSString*)country
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                    message:[NSString stringWithFormat:@"You selected %@",country]
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Cheel out"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)createNewObject
{
    AddInfoController *addInfoController = [[AddInfoController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addInfoController];
    [self presentViewController:navigationController animated:YES completion:nil];
    addInfoController.countryModel = self.countryModel;
    addInfoController.viewContr = self;
}

@end