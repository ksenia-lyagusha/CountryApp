//
//  AddInfoControllerViewController.m
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "AddInfoController.h"
#import "Country.h"
#import "Continent.h"
#import "MagicalRecord.h"
#import "FlagLoading.h"
#import "CountryAppModel.h"

@interface AddInfoController() <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *capitalField;
@property (weak, nonatomic) IBOutlet UITextField *populationField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;

@property (strong, nonatomic) NSArray *continents;

@end

@implementation AddInfoController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.continents = [Continent MR_findAllSortedBy:@"title" ascending:YES];
    self.imageView.layer.cornerRadius = 4.0;
    self.imageView.layer.masksToBounds = YES;
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.countryField becomeFirstResponder];
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
    self.scrollView.contentInset          = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (IBAction)backAndSave:(UIBarButtonItem *)sender
{
    if (sender == self.navigationItem.leftBarButtonItem) {
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
        
    } else if (sender == self.navigationItem.rightBarButtonItem) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        
        self.capitalField.text = [self.capitalField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.countryField.text = [self.countryField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        Country *country = [Country MR_createEntity];
        [country countryWithContinentOrContinentTitle:[self.continents objectAtIndex:index]
                                              country:self.countryField.text
                                              capital:self.capitalField.text
                                           population:@([self.populationField.text integerValue])];
        
        [country addImageObject:self.imageView.image];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.view endEditing:YES];
}

- (void)showAlert:(NSString*)string
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CountryApp"
                                                                   message:[NSString stringWithFormat: @"Sorry, but you have %@ empty fields. Please, fill them in", string]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction  = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    NSString *filtered;
    
    if (textField == self.populationField) {
        cs = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (self.populationField.text.length > 18) {
            return NO;
        }
    return [string isEqualToString:filtered];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if ([textField isEqual:self.countryField]) {
        self.countryField.text = [self.countryField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self imageDownload];
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
    return [self.continents count];
}

#pragma mark - UIPickerViewDelegate

- (NSString*)pickerView:(UIPickerView*)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Continent *continent = [self.continents objectAtIndex:row];
    NSString *str = continent.title;
    return str;
}

#pragma mark - Others

- (void)imageDownload
{
    FlagLoading *flagLoading = [[FlagLoading alloc] init];
    
    NSString *code = [CountryAppModel searchCountryCode:self.countryField.text];
    NSString *link = [flagLoading formatSiteLink:code];
    
    if (code) {
    
        [flagLoading sendRequest:link withImageHandler:^(UIImage * image) {
            
            CGFloat ratio = image.size.height / self.layoutHeight.constant;
            CGFloat newWidth = image.size.width / ratio;
            self.layoutWidth.constant = newWidth;

            self.imageView.image = image;
            if (!self.imageView.image) {
                self.imageView.image = [UIImage imageNamed:@"01"];
            }
        }];
    }
}


@end
