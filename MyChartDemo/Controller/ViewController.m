//
//  ViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalBarChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma Actions
- (IBAction)showBarChartViewClicked:(id)sender {
    UIViewController *view = [[HorizontalBarChartViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

@end
