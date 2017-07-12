//
//  ViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalBarChartViewController.h"
#import "CustomBarChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma Actions

- (IBAction)showBarChartViewClicked:(id)sender {
    UIViewController *view = [[HorizontalBarChartViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)drawBarChartUsingCoreGraphicsClick:(id)sender {
    UIViewController *view = [[CustomBarChartViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

@end
