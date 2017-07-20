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
#import "CustomCircleLabel.h"
#import "BAFluidView.h"
#import "RightRoundCornerLabel.h"

@interface CustomBarChartViewController () {
    NSMutableArray<SimpleHorizontalBarChart *> *chartBackViews;
    NSMutableArray<ValueLabelForBarchart *> *valueLabels;
    NSMutableArray<UIView *> *rankingPanels;
    int ovalPanelRadius;
    UIColor *bronzePanelColor;
    UIColor *silverPanelColor;
    UIColor *goldPanelColor;
}

@property (strong, nonatomic) IBOutlet UIView *membershipView;
@property (strong, nonatomic) IBOutlet RightRoundCornerLabel *membershipLabel;

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

@property (strong, nonatomic) IBOutlet CustomCircleLabel *targetBronzeLabel;
@property (strong, nonatomic) IBOutlet CustomCircleLabel *targetSilverLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cupIconWidth;

@end

@implementation CustomBarChartViewController

- (void)emulateData {
    self.bronzeBarChartValues = [[NSMutableArray alloc] init];
    self.silverBarChartValues = [[NSMutableArray alloc] init];
    self.goldBarChartValues = [[NSMutableArray alloc] init];
    [self.bronzeBarChartValues addObject:@4];
    [self.bronzeBarChartValues addObject:@7];
    [self.silverBarChartValues addObject:@3];
    [self.silverBarChartValues addObject:@4];
    [self.goldBarChartValues addObject:@0];
}

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self putViewsIntoArrays];
    [self emulateData];
    [self mapDataToViews];
    
    ovalPanelRadius = 8;
    bronzePanelColor = [UIColor rgb:166 green:124 blue:0];
    silverPanelColor = [UIColor rgb:146 green:156 blue:157];
    goldPanelColor = [UIColor rgb:255 green:223 blue:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setColorForMultipleViews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self addRightCornerToRankingPanels];
    [self animateFluidView];
    
    int screenHeight = (int) [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight >= 667) { // bigger cup icon size for iPhone s
        self.cupIconWidth.constant = 45;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)putViewsIntoArrays {
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
}

- (void)mapDataToViews {
    self.bronzeBarChart.ratio = @([self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue]);
    self.silverBarChart.ratio = @([self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue]);
    self.bronzeValueLabel.barChartValues = self.bronzeBarChartValues;
    self.silverValueLabel.barChartValues = self.silverBarChartValues;
    self.goldValueLabel.barChartValues = self.goldBarChartValues;
    
    NSString *remainBronze = @"";
    NSString *remainSilver = @"";
    remainBronze = [NSString stringWithFormat:@"%i", (int)[self.bronzeBarChartValues[1] floatValue] - (int)[self.bronzeBarChartValues[0] floatValue]];
    remainSilver = [NSString stringWithFormat:@"%i", (int)[self.silverBarChartValues[1] floatValue] - (int)[self.silverBarChartValues[0] floatValue]];
    self.targetBronzeLabel.text = remainBronze;
    self.targetSilverLabel.text = remainSilver;
}

- (void)setColorForMultipleViews {
    self.membershipView.backgroundColor = UIColor.whiteColor;
    self.panelsContainerBackground.backgroundColor = UIColor.whiteColor;
    self.panelsContainer.backgroundColor = UIColor.whiteColor;
    
    self.bronzePanelOval.backgroundColor = bronzePanelColor;
    self.silverPanelOval.backgroundColor = silverPanelColor;
    self.goldPanelOval.backgroundColor = goldPanelColor;
    self.bronzeLevelTitleLabel.textColor = bronzePanelColor;
    self.silverLevelTitleLabel.textColor = silverPanelColor;
    self.goldLevelTitleLabel.textColor = goldPanelColor;
}

- (void)addRightCornerToRankingPanels {
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

- (void)animateFluidView {
    CGRect fluidViewFrame = self.membershipView.frame;
    fluidViewFrame.size.height = fluidViewFrame.size.height * 3 / 7;
    fluidViewFrame.origin.y = self.membershipView.frame.size.height - fluidViewFrame.size.height;
    
    BAFluidView *view = [[BAFluidView alloc] initWithFrame:fluidViewFrame startElevation:@0.3];
    view.fillColor = [UIColor rgb:203 green:114 blue:117];
    view.strokeColor = [UIColor rgb:203 green:114 blue:117];
    view.fillAutoReverse = false;
    view.fillRepeatCount = 1;
    [view fillTo:@0.6];
    view.fillDuration = 0.4;
    [view startAnimation];
//    view.alpha = 0.2f;
    
    [self.membershipView insertSubview:view belowSubview:self.membershipLabel];
}

#pragma Actions

@end
