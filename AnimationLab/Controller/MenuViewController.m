//
//  ViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "MenuViewController.h"
#import "MembershipViewController.h"
#import "GalleryViewController.h"
#import "UsingUISearchBarViewController.h"
#import "ProgressViewImageViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Main Menu";
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
    GalleryViewController *view = [[GalleryViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)customizeSearchbarTapped:(id)sender {
    UsingUISearchBarViewController *customizeSearchView = [[UsingUISearchBarViewController alloc] init];
    [self.navigationController pushViewController:customizeSearchView animated:true];
}

- (IBAction)touchProgressView:(id)sender {
    ProgressViewImageViewController *view = [[ProgressViewImageViewController alloc] init];
    [self.navigationController pushViewController:view animated:true];
}

@end
