//
//  AddInfoControllerViewController.m
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "AddInfoController.h"
#import "Country.h"
#import <MagicalRecord.h>

@interface AddInfoController()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *capitalField;
@property (weak, nonatomic) IBOutlet UITextField *populationField;
@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation AddInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save up" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBackToViewController:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBackToViewController:)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"Creating new object";
    self.dataSource = [NSArray arrayWithObjects:
                       @"Africa",
                       @"Asia",
                       @"Australia",
                       @"Europe",
                       @"North America",
                       @"South America", nil];
}

-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyBoardDidShow:)
                          name:UIKeyboardDidShowNotification
                        object:nil];
    
    [defaultCenter addObserver:self
                      selector:@selector(keyboardDidHide:)
                          name:UIKeyboardDidHideNotification
                        object:nil];
    
    self.scrollView.contentSize = self.scrollView.frame.size;
    
//    NSLog(@"screen %@", NSStringFromCGRect([self.view frame]));
//    NSLog(@"frame scroll %@", NSStringFromCGRect([self.scrollView frame]));
//    NSLog(@"contentSize %@", NSStringFromCGSize(self.scrollView.contentSize));
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.countryField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)keyBoardDidShow:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize                         = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.scrollView.contentInset          = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, kbSize.height, 0);
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)saveAndBackToViewController:(UIBarButtonItem*)barButtonItem
{
    if (barButtonItem == self.navigationItem.leftBarButtonItem){
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if ([self.countryField.text isEqualToString:@""] || [self.capitalField.text isEqualToString:@""] || [self.populationField.text isEqualToString:@""]) {
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:self.countryField, self.capitalField, self.populationField, nil];
        
        NSMutableArray *otherArray = [NSMutableArray array];
        NSString *str;
        for (UITextField *textField in array) {
            if ([textField.text isEqualToString:@""]) {
                [otherArray addObject:textField.placeholder];
                str = [otherArray componentsJoinedByString:@", "];
                str = str.lowercaseString;
            }
        }
        str = [str stringByReplacingOccurrencesOfString:@"new " withString:@""];
        [self showAlert:str];
        
    } else if (barButtonItem == self.navigationItem.rightBarButtonItem) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        
        Country *entity   = [Country MR_createEntity];
        entity.continent  = [self.dataSource objectAtIndex:index];
        entity.country    = self.countryField.text;
        entity.capital    = self.capitalField.text;
        entity.population = @([self.populationField.text integerValue]);
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showAlert:(NSString*)string
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                   message:[NSString stringWithFormat: @"Sorry, but you have %@ empty fields. Please, fill them in", string]
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
        
        if (self.populationField.text.length > 18) {
            return NO;
        }
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
