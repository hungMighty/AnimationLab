//
//  CustomBarChartViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/12/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "CustomBarChartViewController.h"

@interface CustomBarChartViewController () {
    UIView *holder;
}

@property (strong, nonatomic) IBOutlet UIView *chartUIView;

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self drawRect];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.5 animations:^(void) {
//        CGRect frame = holder.frame;
//        frame.size.width = 50;
//        holder.frame = frame;
//        self.heightCon.constant = 600 // heightCon is the IBOutlet to the constraint
        [holder setFrame:CGRectMake(0, 5, 200, 20)];
    }];
}


- (void)drawRect {
    UIView *rectView = [[UIView alloc] initWithFrame:CGRectMake (0, 5, 50, 20)];
    rectView.backgroundColor = [UIColor blackColor];
    holder = rectView;
    [self.chartUIView addSubview:rectView];
}

#pragma Actions

@end
