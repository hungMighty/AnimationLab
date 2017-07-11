//
//  HorizontalBarChartViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "HorizontalBarChartViewController.h"

@interface HorizontalBarChartViewController () <ChartViewDelegate> {
    NSArray<NSDictionary *> *dataList;
}
@property (strong, nonatomic) IBOutlet HorizontalBarChartView *chartView;

@end

@implementation HorizontalBarChartViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)initialize {
    
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView {
    [chartView setScaleEnabled:NO];
    chartView.dragEnabled = YES;
    chartView.pinchZoomEnabled = NO;
    chartView.chartDescription.enabled = NO;
    chartView.drawGridBackgroundEnabled = NO;
    
    self.chartView.maxVisibleCount = 1;
    self.chartView.highlightPerTapEnabled = NO;
    self.chartView.drawBarShadowEnabled = YES;
    
    ChartXAxis *xAxis = chartView.xAxis;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0;
    xAxis.drawLabelsEnabled = NO;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    ChartYAxis *leftAxis = chartView.leftAxis;
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.drawLabelsEnabled = NO;
    
    ChartYAxis *rightAxis = chartView.rightAxis;
    rightAxis.drawAxisLineEnabled = NO;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.drawLabelsEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Simple Bar Chart";
    self.chartView.delegate = self;
    [self setupBarLineChartView:self.chartView];
    
    [self updateChartData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.chartView animateWithYAxisDuration:2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma Chart data
- (void)updateChartData {
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    [self originalData];
}

- (void)originalData {
    dataList = @[
                 @{@"xValue": @(0),
                   @"yValue": @(1.f),
                   @"xLabel": @"1"},
                 ];
    
    NSMutableArray<BarChartDataEntry *> *values = [[NSMutableArray alloc] init];
    NSMutableArray<UIColor *> *colors = [[NSMutableArray alloc] init];
    
    UIColor *red = [UIColor colorWithRed:211/255.f green:74/255.f blue:88/255.f alpha:1.f];
    
    for (int i = 0; i < dataList.count; i++) {
        NSDictionary *d = dataList[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:[d[@"xValue"] doubleValue] y:[d[@"yValue"] doubleValue]];
        [values addObject:entry];
        
        // specific colors
        [colors addObject:red];
    }
    self.chartView.leftAxis.axisMaximum = 7;
    self.chartView.rightAxis.axisMaximum = 7;
    
    BarChartDataSet *set = set = [[BarChartDataSet alloc] initWithValues:values label:@"Values"];
    set.barShadowColor = [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1.f];
    set.colors = colors;
    set.valueColors = colors;
    
    BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
    [data setValueFont:[UIFont systemFontOfSize:13.f]];
    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.maximumFractionDigits = 1;
//    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
    
    data.barWidth = 0.5;
    
    self.chartView.data = data;
}

#pragma Actions

@end
