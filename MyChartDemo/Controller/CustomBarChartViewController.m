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
#import "CustomRankingPanel.h"

@interface CustomBarChartViewController () {
    NSMutableArray<SimpleHorizontalBarChart *> *chartBackViews;
    NSMutableArray<ValueLabelForBarchart *> *valueLabels;
}


@property (strong, nonatomic) IBOutlet UIView *panelsContainerBackground;
@property (strong, nonatomic) IBOutlet UIView *panelsContainer;

@property (strong, nonatomic) IBOutlet CustomRankingPanel *bronzePanel;
@property (strong, nonatomic) IBOutlet CustomRankingPanel *silverPanel;
@property (strong, nonatomic) IBOutlet CustomRankingPanel *goldPanel;
@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *bronzeBarChart;
@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *silverBarChart;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *bronzeValueLabel;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *silverValueLabel;

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartBackViews = [[NSMutableArray alloc] init];
    [chartBackViews addObject:self.bronzeBarChart];
    [chartBackViews addObject:self.silverBarChart];
    valueLabels = [[NSMutableArray alloc] init];
    [valueLabels addObject:self.bronzeValueLabel];
    [valueLabels addObject:self.silverValueLabel];
    [self mockData];
    self.bronzeBarChart.ratio = @([self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue]);
    self.silverBarChart.ratio = @([self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue]);
    self.bronzeValueLabel.barChartValues = self.bronzeBarChartValues;
    self.silverValueLabel.barChartValues = self.silverBarChartValues;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.panelsContainerBackground.backgroundColor = UIColor.whiteColor;
    self.panelsContainer.backgroundColor = UIColor.whiteColor;
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
