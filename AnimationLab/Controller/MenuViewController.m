//
//  ViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "MenuViewController.h"
#import "MembershipViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma Actions

- (IBAction)cutomizeBarchartsTapped:(id)sender {
    MembershipViewController *view = [[MembershipViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)focusTransitionTapped:(id)sender {
    
}

@end
