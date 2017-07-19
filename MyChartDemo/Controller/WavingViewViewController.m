//
//  WavingViewViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/19/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "WavingViewViewController.h"

@interface WavingViewViewController ()

@property (strong, nonatomic) IBOutlet UIView *wavingView;

@end

@implementation WavingViewViewController

#pragma View Lifecycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self animateRect];
}

#pragma Waving functionality

- (void)animateRect {
    
}

#pragma Actions

@end
