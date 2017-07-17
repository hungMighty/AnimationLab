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
    NSMutableArray<UIView *> *rankingPanels;
    int ovalPanelRadius;
    UIColor *bronzePanelColor;
    UIColor *silverPanelColor;
    UIColor *goldPanelColor;
}


@property (strong, nonatomic) IBOutlet UIView *panelsContainerBackground;
@property (strong, nonatomic) IBOutlet UIView *panelsContainer;

@property (strong, nonatomic) IBOutlet CustomRankingPanel *bronzePanelOval;
@property (strong, nonatomic) IBOutlet CustomRankingPanel *silverPanelOval;
@property (strong, nonatomic) IBOutlet CustomRankingPanel *goldPanelOval;

@property (strong, nonatomic) IBOutlet UIView *bronzePanel;
@property (strong, nonatomic) IBOutlet UIView *silverPanel;
@property (strong, nonatomic) IBOutlet UIView *goldPanel;

@property (strong, nonatomic) IBOutlet UILabel *bronzeLevelTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *silverLevelTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *goldLevelTitleLabel;

@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *bronzeValueLabel;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *silverValueLabel;
@property (strong, nonatomic) IBOutlet ValueLabelForBarchart *goldValueLabel;

@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *bronzeBarChart;
@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *silverBarChart;

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
    [valueLabels addObject:self.goldValueLabel];
    rankingPanels = [[NSMutableArray alloc] init];
    [rankingPanels addObject:self.bronzePanel];
    [rankingPanels addObject:self.silverPanel];
    [rankingPanels addObject:self.goldPanel];
    
    [self mockData];
    
    ovalPanelRadius = 8;
    bronzePanelColor = [UIColor rgb:166 green:124 blue:0];
    silverPanelColor = [UIColor rgb:146 green:156 blue:157];
    goldPanelColor = [UIColor rgb:255 green:223 blue:0];
    
    self.bronzeBarChart.ratio = @([self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue]);
    self.silverBarChart.ratio = @([self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue]);
    self.bronzeValueLabel.barChartValues = self.bronzeBarChartValues;
    self.silverValueLabel.barChartValues = self.silverBarChartValues;
    self.goldValueLabel.barChartValues = self.goldBarChartValues;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setColorForRankingPanelViews];
    for (int i = 0; i < valueLabels.count; i++) {
        [valueLabels[i] addCustomUILabelWithShadow];
        [valueLabels[i] setValueWithColorForLabel];
    }
    [self animateChartRect];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self customRightCornerForRankingPanels];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)mockData {
    self.bronzeBarChartValues = [[NSMutableArray alloc] init];
    self.silverBarChartValues = [[NSMutableArray alloc] init];
    self.goldBarChartValues = [[NSMutableArray alloc] init];
    [self.bronzeBarChartValues addObject:@3];
    [self.bronzeBarChartValues addObject:@7];
    [self.silverBarChartValues addObject:@3];
    [self.silverBarChartValues addObject:@4];
    [self.goldBarChartValues addObject:@0];
}

- (void)setColorForRankingPanelViews {
    self.panelsContainerBackground.backgroundColor = UIColor.whiteColor;
    self.panelsContainer.backgroundColor = UIColor.whiteColor;
    
    self.bronzePanelOval.backgroundColor = bronzePanelColor;
    self.silverPanelOval.backgroundColor = silverPanelColor;
    self.goldPanelOval.backgroundColor = goldPanelColor;
    self.bronzeLevelTitleLabel.textColor = bronzePanelColor;
    self.silverLevelTitleLabel.textColor = silverPanelColor;
    self.goldLevelTitleLabel.textColor = goldPanelColor;
}

- (void)customRightCornerForRankingPanels {
    for (int i = 0; i < rankingPanels.count; i++) {
        UIView *panel = rankingPanels[i];
        UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:panel.bounds
                                                    byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                          cornerRadii:CGSizeMake(ovalPanelRadius, ovalPanelRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = panel.bounds;
        [maskLayer setPath:path.CGPath];
        panel.layer.mask = maskLayer;
    }
}

- (void)animateChartRect {
    for (int i = 0; i < chartBackViews.count; i++) {
        [chartBackViews[i] animeCharRect];
    }
}

#pragma Actions

@end
