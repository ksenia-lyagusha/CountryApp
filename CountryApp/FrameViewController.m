//
//  FrameViewController.m
//  CountryApp
//
//  Created by Оксана on 02.07.15.
//  Copyright (c) 2015 ITCraft. All rights reserved.
//

#import "FrameViewController.h"

#define lineY 50

@interface FrameViewController ()

@end

@implementation FrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(67, 35, 100, 100)];
    greenView.backgroundColor = [UIColor colorWithRed:0.721 green:0.866
                                               blue:0.698 alpha:1];
    
    UIView *pinkView = [[UIView alloc] initWithFrame:CGRectMake(198, 105, 100, 100)];
    pinkView.backgroundColor = [UIColor colorWithRed:0.952 green:0.411
                                                 blue:0.992 alpha:1];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(25, 220, 100, 100)];
    yellowView.backgroundColor = [UIColor colorWithRed:0.941 green:1
                                                  blue:0.705 alpha:1];
    
    UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(187, 256, 47, 22)];
    smallLabel.text = @"Label";
    smallLabel.font = [UIFont systemFontOfSize:17.0];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(91.5, 378, 62, 50)];
    bigLabel.text = @"Two line Label";
    bigLabel.lineBreakMode = NSLineBreakByWordWrapping;
    bigLabel.numberOfLines = 2;
    bigLabel.font = [UIFont boldSystemFontOfSize:15.0];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(150.5, 451, 57, 26)];
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.066 green:0.474 blue:0.988 alpha:1] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont italicSystemFontOfSize:15];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, 320, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    
    CGFloat wigth = self.view.frame.size.width;
    CGFloat heightView = self.view.frame.size.height;
    CGFloat distanceFromTopToLine = lineView.frame.origin.y;
    CGFloat distanceFromLeftToCenter = wigth / 2;
    
    CGFloat buttonHeight = 20;
    CGFloat buttonWidth = 100;
    UIButton *buttonUnderLine = [[UIButton alloc] initWithFrame:CGRectMake(distanceFromLeftToCenter - buttonWidth / 2, ((heightView + distanceFromTopToLine) / 2 - buttonHeight / 2), buttonWidth, buttonHeight)];
    NSLog(@"distance From Top To Line = %f", (heightView + distanceFromTopToLine) / 2);
    [buttonUnderLine setTitle:@"Button" forState:UIControlStateNormal];
    [buttonUnderLine setTitleColor:[UIColor colorWithRed:0.066 green:0.474 blue:0.988 alpha:1] forState:UIControlStateNormal];
     buttonUnderLine.titleLabel.font = [UIFont italicSystemFontOfSize:15];
    buttonUnderLine.backgroundColor = [UIColor orangeColor];
    
    
    UIView *lineCenter = [[UIView alloc] initWithFrame:CGRectMake(0, (heightView + distanceFromTopToLine)/2, 320, 1)];
    lineCenter.backgroundColor = [UIColor blackColor];
    
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(wigth /2, 0, 1, 568)];
    verticalLine.backgroundColor = [UIColor blackColor];
    
//    [self.view addSubview:greenView];
//    [self.view addSubview:pinkView];
//    [self.view addSubview:yellowView];
//    [self.view addSubview:smallLabel];
//    [self.view addSubview:bigLabel];
//    [self.view addSubview:button];
    [self.view addSubview:lineView];
    [self.view addSubview:buttonUnderLine];
    [self.view addSubview:lineCenter];
    [self.view addSubview:verticalLine];
    
     NSLog(@"screen %@", NSStringFromCGRect([self.view frame]));
    
    self.view.backgroundColor = [UIColor whiteColor];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
