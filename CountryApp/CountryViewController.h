//
//  CountryViewController.h
//  CountryApp
//
//  Created by Sander on 29.03.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicalRecord.h"

@interface CountryViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
