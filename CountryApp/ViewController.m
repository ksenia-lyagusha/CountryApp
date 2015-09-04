//
//  ViewController.m
//  CountryApp
//
//  Created by Оксана on 14.07.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.label.text = @"A UINavigationItem object manages the buttons and views to be displayed in a UINavigationBar object. When building a navigation interface, each view controller pushed onto the navigation stack must have a UINavigationItem object that contains the buttons and views it wants displayed in the navigation bar. The managing UINavigationController object uses the navigation items of the topmost two view controllers to populate the navigation bar with content.";
    CGSize maximumLabelSize = CGSizeMake(self.label.frame.size.width, CGFLOAT_MAX);
    CGRect size = [self.label.text boundingRectWithSize:maximumLabelSize
                                                options: NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:self.label.font}
                                                context:nil];

    CGRect dgzd = self.label.frame;
    dgzd.size.height = size.size.height;
    self.label.frame = dgzd;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
