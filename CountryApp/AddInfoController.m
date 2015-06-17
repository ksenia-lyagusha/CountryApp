//
//  AddInfoControllerViewController.m
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "AddInfoController.h"
#import "CountryInfo.h"
#import "CountryModel.h"

@interface AddInfoController()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *capitalField;
@property (weak, nonatomic) IBOutlet UITextField *populationField;
@property (strong, nonatomic) NSArray *dataSource;

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
        [[CountryModel sharedInstance] addNewObject:allValues];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)backToViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.countryField.text isEqualToString:@""])
    {
        
    }
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
