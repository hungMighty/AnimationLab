//
//  CustomBarChartViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/12/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "CustomBarChartViewController.h"
#import "UtilityClasses.h"
#import "SimpleHorizontalBarChart.h"
#import "ValueLabelForBarchart.h"

@interface CustomBarChartViewController () {
    NSMutableArray<SimpleHorizontalBarChart *> *chartBackViews;
    NSMutableArray<ValueLabelForBarchart *> *valueLabels;
}

@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *bronzeBarChart;
@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *silverBarChart;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *bronzeValueView;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *silverValueView;

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartBackViews = [[NSMutableArray alloc] init];
    [chartBackViews addObject:self.bronzeBarChart];
    [chartBackViews addObject:self.silverBarChart];
    valueLabels = [[NSMutableArray alloc] init];
    [valueLabels addObject:self.bronzeValueView];
    [valueLabels addObject:self.silverValueView];
    [self mockData];
    self.bronzeBarChart.ratio = @([self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue]);
    self.silverBarChart.ratio = @([self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue]);
    self.bronzeValueView.barChartValues = self.bronzeBarChartValues;
    self.silverValueView.barChartValues = self.silverBarChartValues;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i = 0; i < valueLabels.count; i++) {
        [valueLabels[i] addCustomUILabelWithShadow];
    }
    [self animateChartRect];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)mockData {
    self.bronzeBarChartValues = [[NSMutableArray alloc] init];
    self.silverBarChartValues = [[NSMutableArray alloc] init];
    [self.bronzeBarChartValues addObject:@3];
    [self.bronzeBarChartValues addObject:@7];
    [self.silverBarChartValues addObject:@3];
    [self.silverBarChartValues addObject:@4];
}

- (void)animateChartRect {
    for (int i = 0; i < chartBackViews.count; i++) {
        [chartBackViews[i] animeCharRect];
    }
}

#pragma Actions

@end
