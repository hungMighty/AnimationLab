//
//  CustomBarChartViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/12/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "CustomBarChartViewController.h"
#import "UtilityClasses.h"

@interface CustomBarChartViewController () {
    CGFloat chartCornerRadius;
    NSMutableArray<UIView *> *chartBackViews;
}

@property (strong, nonatomic) IBOutlet UIView *bronzeBarChart;
@property (strong, nonatomic) IBOutlet UIView *silverBarChart;

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartCornerRadius = 6;
    chartBackViews = [[NSMutableArray alloc] init];
    [chartBackViews addObject:self.bronzeBarChart];
    [chartBackViews addObject:self.silverBarChart];
    [self mockData];
    [self customizeBarchartBackground];
    [self drawChartRect];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateChartRect];
}

- (void)mockData {
    self.bronzeBarChartValues = [[NSMutableArray alloc] init];
    self.silverBarChartValues = [[NSMutableArray alloc] init];
    [self.bronzeBarChartValues addObject:@6];
    [self.bronzeBarChartValues addObject:@7];
    [self.silverBarChartValues addObject:@3];
    [self.silverBarChartValues addObject:@4];
}

- (void)customizeBarchartBackground {
    for (int i = 0; i < chartBackViews.count; i++) {
        UIView *chartBackView = chartBackViews[i];
        chartBackView.layer.masksToBounds = YES;
        chartBackView.layer.cornerRadius = chartCornerRadius;
        chartBackView.backgroundColor = UIColor.whiteColor;
        chartBackView.layer.borderColor = [UIColor rgb:240 green:240 blue:240].CGColor;
        chartBackView.layer.borderWidth = 1.0f;
    }
}

- (void)drawChartRect {
    for (int i = 0; i < chartBackViews.count; i++) {
        UIView *chartBackView = chartBackViews[i];
        UIColor *startColor = [UIColor rgb:147 green:57 blue:62];
        UIColor *endColor = [UIColor rgb:200 green:68 blue:75];
        UIView *chartRect = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 0, 10)];
        chartRect.layer.masksToBounds = YES;
        chartRect.layer.cornerRadius = chartCornerRadius;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = chartRect.bounds;
        gradient.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
        [gradient setStartPoint:CGPointMake(0.0, 0.5)];
        [gradient setEndPoint:CGPointMake(1.0, 0.5)];
        [chartRect.layer insertSublayer:gradient atIndex:0];
        
        [chartBackView addSubview:chartRect];
    }
}

- (void)animateChartRect {
    UIView *bronzeChartFrontView = chartBackViews[0].subviews.firstObject;
    CGFloat ratio = [self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue];
    CGFloat newWidth = chartBackViews[0].frame.size.width * ratio;
    [UIView animateWithDuration:1.5 animations:^(void) {
        [bronzeChartFrontView setFrame:CGRectMake(0, 0, newWidth, 10)];
        [bronzeChartFrontView.layer.sublayers.firstObject setFrame:CGRectMake(0, 0, newWidth, 10)];
    }];
    UIView *silverChartFrontView = chartBackViews[1].subviews.firstObject;
    ratio = [self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue];
    newWidth = chartBackViews[1].frame.size.width * ratio;
    [UIView animateWithDuration:1.5 animations:^(void) {
        [silverChartFrontView setFrame:CGRectMake(0, 0, newWidth, 10)];
        [silverChartFrontView.layer.sublayers.firstObject setFrame:CGRectMake(0, 0, newWidth, 10)];
    }];
}

#pragma Actions

@end
