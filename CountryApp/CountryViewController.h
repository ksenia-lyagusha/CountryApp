//
//  CountryViewController.h
//  CountryApp
//
//  Created by Sander on 29.03.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
