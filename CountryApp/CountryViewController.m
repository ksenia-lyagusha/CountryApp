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
//    
//    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@25, @8, @1991, @24, nil];
//    for (int i = 0; i < array.count-1; i++) {
//        for (int j = 0; j < array.count-1; j++) {
//            if (array[j] > array[j+1]) {
//                int k = [array[j+1] intValue];
//                array[j+1] = array[j];
//                array[j] = @(k);
//            }
//        }
//    }
//    NSLog(@"%@", array);

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
    return [self.countryModel countOfCountries];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.countryModel getNameOfCountryForIndex:indexPath.row];
    cell.detailTextLabel.text = [self.countryModel getNameOfCapitalForIndex:indexPath.row];
    
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