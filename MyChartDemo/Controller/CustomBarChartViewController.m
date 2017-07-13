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

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartCornerRadius = 6;
    chartBackViews = [[NSMutableArray alloc] init];
    [chartBackViews addObject:self.bronzeBarChart];
    [self customizeBarchartBackground];
    [self drawChartRect];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateChartRect];
}

- (void)customizeBarchartBackground {
    self.bronzeBarChart.layer.cornerRadius = chartCornerRadius;
    self.bronzeBarChart.layer.masksToBounds = YES;
    self.bronzeBarChart.backgroundColor = UIColor.whiteColor;
}

- (void)drawChartRect {
    for (int i = 0; i < chartBackViews.count; i++) {
        UIView *chartBackView = chartBackViews[i];
        UIColor *startColor = [UIColor rgb:147 green:57 blue:62];
        UIColor *endColor = [UIColor rgb:200 green:68 blue:75];
        UIView *chartRect = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 0, 10)];
        chartRect.layer.cornerRadius = chartCornerRadius;
        chartRect.layer.masksToBounds = YES;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = chartRect.bounds;
        gradient.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
        [gradient setStartPoint:CGPointMake(0.0, 0.5)];
        [gradient setEndPoint:CGPointMake(1.0, 0.5)];
        [chartRect.layer insertSublayer:gradient atIndex:0];
        
        [chartBackView addSubview:chartRect];
        
        CALayer *border = [CALayer layer];
        border.backgroundColor = [UIColor rgb:240 green:240 blue:240].CGColor;
        border.frame = CGRectMake(0, 10 - 1, 200, 1);
        [chartBackView.layer addSublayer:border];
    }
}

- (void)animateChartRect {
    UIView *bronzeChartFrontView = chartBackViews[0].subviews.firstObject;
    [UIView animateWithDuration:1.5 animations:^(void) {
        [bronzeChartFrontView setFrame:CGRectMake(0, 0, 140, 10)];
        [bronzeChartFrontView.layer.sublayers.firstObject setFrame:CGRectMake(0, 0, 140, 10)];
    }];
}

#pragma Actions

@end
