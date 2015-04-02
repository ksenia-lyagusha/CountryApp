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
    [self.countryModel fillArray];
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str;
    if (section == 0) {
        str = @"Europe";
    } else {
        str = @"Asia";
    }
    return str;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectiontableView
{
    return self.countryModel.countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
    }
   
    cell.textLabel.text = self.countryModel.countries[indexPath.row];
    cell.detailTextLabel.text = self.countryModel.capitals[indexPath.row];
    
    return cell;
}

#pragma mark - Delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showAlert:self.countryModel.countries[indexPath.row]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

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