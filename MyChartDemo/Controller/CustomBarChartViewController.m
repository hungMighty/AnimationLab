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

@interface CustomBarChartViewController () {
    NSMutableArray<SimpleHorizontalBarChart *> *chartBackViews;
}

@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *bronzeBarChart;
@property (strong, nonatomic) IBOutlet SimpleHorizontalBarChart *silverBarChart;
@property (strong, nonatomic) IBOutlet UIView *bronzeValueView;
@property (strong, nonatomic) IBOutlet UILabel *silverValueLabel;

@end

@implementation CustomBarChartViewController

#pragma View LifeCycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    chartBackViews = [[NSMutableArray alloc] init];
    [chartBackViews addObject:self.bronzeBarChart];
    [chartBackViews addObject:self.silverBarChart];
    [self mockData];
    self.bronzeBarChart.ratio = @([self.bronzeBarChartValues[0] floatValue] / [self.bronzeBarChartValues[1] floatValue]);
    self.silverBarChart.ratio = @([self.silverBarChartValues[0] floatValue] / [self.silverBarChartValues[1] floatValue]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customizeLabels];
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

- (void)customizeLabels {
    // Add Shadow to bar chart
    CGFloat labelMargin = 3.f;
    CGRect superFrame = self.bronzeValueView.frame;
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0.5f,
                                                                  0.5f,
                                                                  superFrame.size.width - labelMargin,
                                                                  superFrame.size.height - labelMargin)];
    shadowView.backgroundColor = UIColor.clearColor;
    shadowView.layer.masksToBounds = false;
    shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
    shadowView.layer.shadowOpacity = 0.2f;
    shadowView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    shadowView.layer.shadowRadius = 1.5f;
    
    UILabel *bronzeValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5f,
                                                                          0.5f,
                                                                          superFrame.size.width - labelMargin,
                                                                          superFrame.size.height - labelMargin)];
    [bronzeValueLabel setText:[NSString stringWithFormat:@"%li / %li", (long)[self.bronzeBarChartValues[0] integerValue], (long)[self.bronzeBarChartValues[1] integerValue]]];
    [bronzeValueLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bronzeValueLabel setTextAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: bronzeValueLabel.attributedText];
    UIColor *textColor = [UIColor rgb:174 green:14 blue:25];
    [text addAttribute:NSForegroundColorAttributeName
                 value:textColor
                 range:NSMakeRange(0, 1)];
    [bronzeValueLabel setAttributedText: text];
    bronzeValueLabel.backgroundColor = UIColor.whiteColor;
    bronzeValueLabel.layer.cornerRadius = bronzeValueLabel.frame.size.height / 2;
    bronzeValueLabel.layer.masksToBounds = true;
    
    [shadowView addSubview:bronzeValueLabel];
    [self.bronzeValueView addSubview:shadowView];
    self.bronzeValueView.layer.cornerRadius = bronzeValueLabel.frame.size.height / 2;
//    [self.bronzeValueView setBackgroundColor:UIColor.redColor];
    [self.bronzeValueView setBackgroundColor:UIColor.clearColor];
    self.bronzeValueView.layer.masksToBounds = true;
}

- (void)animateChartRect {
    for (int i = 0; i < chartBackViews.count; i++) {
        [chartBackViews[i] animeCharRect];
    }
}

#pragma Actions

@end
