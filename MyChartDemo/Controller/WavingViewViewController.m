//
//  WavingViewViewController.m
//  MyChartDemo
//
//  Created by Ahri on 7/19/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "WavingViewViewController.h"
#import "UIColor+RGB.h"

@interface WavingViewViewController ()

@property (strong, nonatomic) IBOutlet UIView *wavingView;

@property (strong,nonatomic) CAShapeLayer *lineLayer;
@property (assign,nonatomic) int waveLength;//** 2 UIBezierPaths = 1 wavelength
@property (assign,nonatomic) int finalX;

@end

@implementation WavingViewViewController

#pragma View Lifecycles

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self animateWave];
}

#pragma Waving functionality

- (void)animateWave {
    [self initialize];
}

- (void)initialize {
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.fillColor = [UIColor colorWithHex:0x6BB9F0].CGColor;
    self.lineLayer.strokeColor = [UIColor colorWithHex:0x6BB9F0].CGColor;
    
    self.waveLength = CGRectGetWidth(self.wavingView.frame);
    self.finalX = 5*self.waveLength;
    
    //creating a linelayer frame
    self.lineLayer.anchorPoint = CGPointMake(0, 0);
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.wavingView.frame), 50, CGRectGetHeight(self.wavingView.frame));
    self.lineLayer.frame = frame;
    
    [self.wavingView.layer addSublayer:self.lineLayer];
}

#pragma Actions

@end
