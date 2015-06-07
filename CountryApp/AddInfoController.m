//
//  AddInfoControllerViewController.m
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "AddInfoController.h"
#import "CountryInfo.h"

@interface AddInfoController()

@end

@implementation AddInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save up" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBackToViewController:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBackToViewController:)];
    self.title = @"Creating new object";
    self.dataSource = [NSArray arrayWithObjects:
                       @"Africa",
                       @"Asia",
                       @"Australia",
                       @"Europe",
                       @"North America",
                       @"South America", nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.countryField becomeFirstResponder];
}

- (void)saveAndBackToViewController:(UIBarButtonItem*)barButtonItem
{
    if (barButtonItem == self.navigationItem.rightBarButtonItem) {
        CountryInfo *allValues = [[CountryInfo alloc] init];
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        allValues.continentTitle  = [self.dataSource objectAtIndex:index];
        allValues.countryTitle = self.countryField.text;
        allValues.capitalTitle = self.capitalField.text;
        allValues.population = @([self.populationField.text intValue]);
        [self.countryModel addNewObject:allValues];
        [self.viewContr.tableView reloadData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)backToViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.populationField)
    {
        NSCharacterSet *cs = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if ([textField isEqual:self.countryField]) {
        [self.capitalField becomeFirstResponder];
    } else if ([textField isEqual:self.capitalField]) {
        [self.populationField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}

#pragma mark - IPickerViewDelegate

- (NSString*)pickerView:(UIPickerView*)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataSource objectAtIndex:row];
}

@end
