//
//  AddInfoControllerViewController.m
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "AddInfoController.h"
#import "Continent.h"
#import "MagicalRecord.h"
#import "FlagLoading.h"
#import "CountryAppModel.h"
#import "LocationViewController.h"
#import <MapKit/MapKit.h>

@interface AddInfoController() <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, LocationViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *capitalField;
@property (weak, nonatomic) IBOutlet UITextField *populationField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;

@property (strong, nonatomic) NSArray *continents;

@property CLLocationCoordinate2D coordinates;

@end

@implementation AddInfoController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.continents = [Continent MR_findAllSortedBy:@"title" ascending:YES];
    self.imageView.layer.cornerRadius = 4.0;
    self.imageView.layer.masksToBounds = YES;
    
    if (self.countryObj) {
        self.title = @"Editing...";
        self.countryField.text = self.countryObj.title;
        self.capitalField.text = self.countryObj.capital;
        self.populationField.text = [self.countryObj.population stringValue];
        
        NSInteger index = [self.continents indexOfObject:self.countryObj.continent];
        [self.pickerView selectRow:index inComponent:0 animated:NO];
        
        self.coordinates = CLLocationCoordinate2DMake(self.countryObj.latitudeValue, self.countryObj.longitudeValue);
    }
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
    
    // add notification to listen events about changing coordinates
//    [defaultCenter addObserver:self
//                      selector:@selector(receiveTestNotification:)
//                          name:@"TestNotification"
//                        object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.countryField becomeFirstResponder];
}

- (void)keyBoardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize      = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets   = self.scrollView.contentInset;
    contentInsets.bottom         = kbSize.height;
    
    self.scrollView.contentInset          = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets   = self.scrollView.contentInset;
    contentInsets.bottom         = 0;
    
    self.scrollView.contentInset          = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
}

 // add notification to listen events about changing coordinates
//- (void)receiveTestNotification:(NSNotification *)notification
//{
//    if ([notification.name isEqualToString:@"TestNotification"]) {
//        NSDictionary* userInfo = notification.userInfo;
//
//        self.coordinates = [userInfo[@"coord2D"] MKCoordinateValue];
//    }
//}

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
        
        Country *country = (!self.countryObj) ? [Country MR_createEntity] : self.countryObj;
        
        [country countryWithContinentOrContinentTitle:[self.continents objectAtIndex:index]
                                              country:self.countryField.text
                                              capital:self.capitalField.text
                                           population:@([self.populationField.text integerValue])];
        
        [country addLongitude:self.coordinates.longitude andLatitude:self.coordinates.latitude];
        [country addImageObject:self.imageView.image];
        
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        //notification
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
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
        [self backAndSave:self.navigationItem.rightBarButtonItem];
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
    return [[self.continents objectAtIndex:row] title];
}

#pragma mark - Others

- (void)imageDownload
{
    NSString *code = [CountryAppModel searchCountryCode:self.countryField.text];
    
    if (code) {
        FlagLoading *flagLoading = [FlagLoading sharedInstance];
         NSString *link = [flagLoading formatSiteLink:code];
         __weak AddInfoController *weakSelf = self;
        
        [flagLoading sendRequest:link withImageHandler:^(UIImage * image) {
           
            if (!image) {
                weakSelf.imageView.image = [UIImage imageNamed:@"notFound"];
                return ;
            }
            CGFloat ratio = image.size.height / weakSelf.layoutHeight.constant;
            CGFloat newWidth = image.size.width / ratio;
            weakSelf.layoutWidth.constant = newWidth;

            weakSelf.imageView.image = image;
        }];
    } else {
        self.imageView.image = [UIImage imageNamed:@"notFound"];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LocationSegue"]) {
        LocationViewController *locationVC = [segue destinationViewController];
//        locationVC.delegate = self;
        locationVC.coordinates2D = self.coordinates;
        
        // block 
        __weak AddInfoController *weekSelf = self;
        [locationVC fetchCoordinatesWithBlock:^(CLLocationCoordinate2D coord2D){
            weekSelf.coordinates = coord2D;
        }];
    }
}

#pragma mark - LocationViewDelegate

- (void)obtainCoordinates:(CLLocationCoordinate2D)coordinates
{
    self.coordinates = coordinates;
}
@end
