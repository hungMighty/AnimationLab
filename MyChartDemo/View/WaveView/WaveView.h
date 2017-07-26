//
//  WaveView.h
//  MyChartDemo
//
//  Created by Ahri on 7/21/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RGB.h"

@interface WaveView : UIView

@property (assign, nonatomic) CGFloat angularSpeed;
@property (assign, nonatomic) CGFloat waveSpeed;
@property (assign, nonatomic) CGFloat steepIncrementUnit;
@property (assign, nonatomic) NSTimeInterval waveTime;
@property (strong, nonatomic) UIColor *waveColor;

+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;

- (BOOL)wave;
- (void)stop;

@end
