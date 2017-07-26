//
//  MembershipViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/12/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "MembershipViewController.h"
#import "UtilityClasses.h"
#import "SimpleHorizontalBarChart.h"
#import "ValueLabelForBarchart.h"
#import "CustomRankingPanel.h"
#import "CustomCircleLabel.h"
#import "BAFluidView.h"
#import "RightRoundCornerLabel.h"
#import "GroupButtonWithColor.h"
#import "WaveView.h"

@interface MembershipViewController () {
    NSMutableArray<SimpleHorizontalBarChart *> *chartBackViews;
    NSMutableArray<ValueLabelForBarchart *> *valueLabels;
    NSMutableArray<UIView *> *rankingPanels;
    int ovalPanelRadius;
    UIColor *bronzePanelColor;
    UIColor *silverPanelColor;
    UIColor *goldPanelColor;
    CGFloat waveHeight;
}

@property (strong, nonatomic) IBOutlet GroupButtonWithColor *membershipButton;
@property (strong, nonatomic) IBOutlet GroupButtonWithColor *topResultButton;
@property (strong, nonatomic) IBOutlet GroupButtonWithColor *currentRankButton;

@property (strong, nonatomic) IBOutlet UIView *membershipView;
@property (strong, nonatomic) IBOutlet RightRoundCornerLabel *membershipLabel;
@property (strong, nonatomic) UIView *waveViewContainer;
@property (strong, nonatomic) WaveView *waveView;
@property (strong, nonatomic) WaveView *shadowWaveView;

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

@implementation MembershipViewController

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
    [self animateWaveView];
    
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
    NSMutableArray<GroupButtonWithColor *> *topButtonsGroup = [[NSMutableArray alloc]
                                                        initWithObjects:self.membershipButton,
                                                        self.topResultButton,
                                                        self.currentRankButton, nil];
    self.membershipButton.buttonsGroup = topButtonsGroup;
    self.topResultButton.buttonsGroup = topButtonsGroup;
    self.currentRankButton.buttonsGroup = topButtonsGroup;
}

- (void)mapDataToViews {
    self.membershipLabel.labelTitle = @"Membership";
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

- (void)animateWaveView {
    UIColor *redColor = [UIColor rgb:203 green:114 blue:117];
    UIColor *shadowRedColor = [UIColor rgb:247 green:232 blue:233];
    waveHeight = 9;
    CGFloat waveTimeOfFrontWave = 1;
    CGFloat shadowWaveDispatchTime = 0.3f;
    
    CGRect waveContainerFrame = self.membershipView.frame;
    waveContainerFrame.size.height = 0;
    waveContainerFrame.origin.y = self.membershipView.frame.size.height - waveContainerFrame.size.height;
    if (self.waveViewContainer != nil) {
        [self.waveViewContainer removeFromSuperview];
        self.waveView = nil;
        self.shadowWaveView = nil;
    }
    self.waveViewContainer = [[UIView alloc] initWithFrame:waveContainerFrame];
    self.waveViewContainer.clipsToBounds = false;
    self.waveViewContainer.backgroundColor = redColor;
    [self.membershipView insertSubview:self.waveViewContainer belowSubview:self.membershipLabel];
    
    // Add new Shadow WaveView
    self.shadowWaveView = [WaveView addToView:self.waveViewContainer
                              withFrame:CGRectMake(0, -(waveHeight - 0.2),
                                                   self.waveViewContainer.frame.size.width, waveHeight)];
    self.shadowWaveView.waveColor = shadowRedColor;
    self.shadowWaveView.angularSpeed = 2.5f;
    self.shadowWaveView.steepIncrementUnit = 0.2f;
    self.shadowWaveView.waveTime = waveTimeOfFrontWave - shadowWaveDispatchTime; // make wave view animate indefinitely with input -1
    
    // Add new waveView
    UIColor *redColorWithAlpha = [redColor colorWithAlphaComponent:0.6];
    self.waveView = [WaveView addToView:self.waveViewContainer
                              withFrame:CGRectMake(0, -(waveHeight - 0.2),
                                                   self.waveViewContainer.frame.size.width, waveHeight)];
    self.waveView.waveColor = redColorWithAlpha;
    self.waveView.angularSpeed = 2.5f;
    self.waveView.steepIncrementUnit = 0.2f;
    self.waveView.waveTime = waveTimeOfFrontWave; // make wave view animate indefinitely with input -1
    
    // Start Animating waves
    [self.waveView wave];
//    [self.shadowWaveView wave];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(shadowWaveDispatchTime * 1000 * NSEC_PER_MSEC)),
                   dispatch_get_main_queue(), ^{
                       [self.shadowWaveView wave];
                   });
    
    // Animate waveViewContainer to go up from bottom
//    waveContainerFrame.size.height = 0;
//    waveContainerFrame.origin.y = self.membershipView.frame.size.height - waveContainerFrame.size.height;
//    [UIView animateWithDuration:2.5f animations:^{
//        [self.waveViewContainer setFrame:waveContainerFrame];
//    } completion:^(BOOL finished) {
//        CGRect waveViewFrame = self.waveView.frame;
//        waveViewFrame.origin.y = -(waveHeight - 0.05);
//        self.waveView.frame = waveViewFrame;
//    }];
}

#pragma Actions

- (IBAction)membershipClicked:(id)sender {
    NSLog(@"Membership button clicked");
}

@end
