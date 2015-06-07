//
//  AddInfoControllerViewController.h
//  CountryApp
//
//  Created by Sander on 27.05.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CountryModel.h"
#import "CountryViewController.h"

@interface AddInfoController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *capitalField;
@property (weak, nonatomic) IBOutlet UITextField *populationField;
@property CountryModel *countryModel;
@property (strong, nonatomic) NSArray *dataSource;
@property CountryViewController *viewContr;
@end
