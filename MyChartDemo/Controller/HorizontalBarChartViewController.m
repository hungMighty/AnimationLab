//
//  HorizontalBarChartViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/11/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "HorizontalBarChartViewController.h"

@interface HorizontalBarChartViewController () <ChartViewDelegate> {
    NSArray<HorizontalBarChartView *> *chartViews;
}
@property (weak, nonatomic) IBOutlet HorizontalBarChartView *bronzeChartView;
@property (weak, nonatomic) IBOutlet HorizontalBarChartView *silverChartView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Simple Bar Chart";
    self.bronzeChartView.delegate = self;
    self.silverChartView.delegate = self;
    chartViews = @[ self.bronzeChartView, self.silverChartView ];
    if (self.dataList == nil) {
        self.dataList = [[NSMutableArray<NSDictionary *> alloc] init];
        [self.dataList addObject:@{@"xValue": @(0),
                                   @"yValue": @(4),
                                   @"yMaxValue": @(7)}];
        [self.dataList addObject:@{@"xValue": @(0),
                                   @"yValue": @(2),
                                   @"yMaxValue": @(4)}];
    }
    
    [self setupBarLineChartView];
    [self populateData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customizeChartView];
    for (int i = 0; i < chartViews.count; i++) {
        [chartViews[i] animateWithYAxisDuration:0.75];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma ChartView Customization

- (void)setupBarLineChartView {
    for (int i = 0; i < chartViews.count; i++) {
        HorizontalBarChartView *chartView = chartViews[i];
        
        [chartView setScaleEnabled:NO];
        chartView.dragEnabled = YES;
        chartView.pinchZoomEnabled = NO;
        chartView.chartDescription.enabled = NO;
        chartView.drawGridBackgroundEnabled = NO;
        
        chartView.maxVisibleCount = 1;
        chartView.highlightPerTapEnabled = NO;
        chartView.drawBarShadowEnabled = YES;
        
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
        
        ChartLegend *chartLegend = chartView.legend;
        chartLegend.enabled = NO;
    }
}

- (void)customizeChartView {
    for (int i = 0; i < chartViews.count; i++) {
        HorizontalBarChartView *chartView = chartViews[i];
//        chartView.backgroundColor = UIColor.brownColor;
        chartView.extraLeftOffset = -15.f;
    }
}

#pragma Chart data

- (void)populateData {
    UIColor *chartViewForegroundColor = [UIColor colorWithRed:211/255.f green:74/255.f blue:88/255.f alpha:1.f];
    UIColor *chartViewShadowColor = [UIColor colorWithRed:255/255.f green:213/255.f blue:213/255.f alpha:1.f];
    
    for (int i = 0; i < chartViews.count; i++) {
        HorizontalBarChartView *barChartView = chartViews[i];
        NSMutableArray<BarChartDataEntry *> *chartStatistics = [[NSMutableArray alloc] init];
        NSMutableArray<UIColor *> *colors = [[NSMutableArray alloc] init];
        
        NSDictionary *dict = self.dataList[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:[dict[@"xValue"] doubleValue] y:[dict[@"yValue"] doubleValue]];
        [chartStatistics addObject:entry];
        [colors addObject:chartViewForegroundColor];
        
        BarChartDataSet *set = set = [[BarChartDataSet alloc] initWithValues:chartStatistics label:@"Values"];
        set.barShadowColor = chartViewShadowColor;
        set.colors = colors;
        set.valueColors = colors;
        
        BarChartData *data = [[BarChartData alloc] initWithDataSet:set];
        [data setValueFont:[UIFont systemFontOfSize:13.f]];
        data.barWidth = 1;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterRoundUp;
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
        
        barChartView.data = data;
        barChartView.leftAxis.axisMinimum = 0;
        barChartView.rightAxis.axisMinimum = 0;
        barChartView.leftAxis.axisMaximum = [dict[@"yMaxValue"] doubleValue];
        barChartView.rightAxis.axisMaximum = [dict[@"yMaxValue"] doubleValue];
    }
}

#pragma Actions


@end
