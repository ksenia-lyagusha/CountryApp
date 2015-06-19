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
@property NSString *string;
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
    if (barButtonItem == self.navigationItem.leftBarButtonItem){
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if ([self.countryField.text isEqualToString:@""] || [self.capitalField.text isEqualToString:@""] || [self.populationField.text isEqualToString:@""]) {
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:self.countryField, self.capitalField, self.populationField, nil];
        
        NSMutableArray *otherArray = [NSMutableArray array];
        for (UITextField *textField in array) {
            if ([textField.text isEqualToString:@""]) {
                [otherArray addObject:textField.placeholder];
                self.string = [otherArray componentsJoinedByString:@", "];
                self.string = self.string.lowercaseString;
            }
        }
        self.string = [self.string stringByReplacingOccurrencesOfString:@"new " withString:@""];
        [self showAlert:self.string];
        
    } else if (barButtonItem == self.navigationItem.rightBarButtonItem) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        CountryInfo *allValues = [[CountryInfo alloc] init];
        allValues.continentTitle  = [self.dataSource objectAtIndex:index];
        allValues.countryTitle = self.countryField.text;
        allValues.capitalTitle = self.capitalField.text;
        allValues.population = @([self.populationField.text intValue]);
        [[CountryModel sharedInstance] addNewObject:allValues];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showAlert:(NSString*)srting
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                   message:[NSString stringWithFormat: @"Sorry, but you have %@ empty fields. Please, fill them in", self.string]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
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
