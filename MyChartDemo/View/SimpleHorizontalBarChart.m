//
//  SimpleHorizontalBarChart.m
//  MyChartDemo
//
//  Created by Ahri on 7/14/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "SimpleHorizontalBarChart.h"
#import "UtilityClasses.h"

@interface SimpleHorizontalBarChart () {
    CGFloat chartCornerRadius;
}

@end

@implementation SimpleHorizontalBarChart

// load from nib
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefaultStatistics];
        [self customizeBarchartBackground];
        [self drawForegroundRect];
    }
    return self;
}

// custom init with frame
- (id)initWithFrame:(CGRect)aRect {
    if (self = [super initWithFrame:aRect]) {
        [self initDefaultStatistics];
        [self customizeBarchartBackground];
        [self drawForegroundRect];
    }
    return self;
}

- (void)initDefaultStatistics {
    chartCornerRadius = 6;
    if (self.startColor == nil) {
        self.startColor = [UIColor rgb:147 green:57 blue:62];
    }
    if (self.endColor == nil) {
        self.endColor = [UIColor rgb:200 green:68 blue:75];
    }
    if (self.charHeight == nil) {
        self.charHeight = @10;
    }
    if (self.animationDuration == nil) {
        self.animationDuration = @1.5;
    }
}

- (void)customizeBarchartBackground {
    self.layer.cornerRadius = chartCornerRadius;
    self.backgroundColor = UIColor.whiteColor;
    
    // Add Border to bar chart
//    self.layer.borderColor = [UIColor rgb:240 green:240 blue:240].CGColor;
//    self.layer.borderWidth = 1.0f;
    
    // Add Shadow to bar chart
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.layer.shadowRadius = 3.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

- (void)drawForegroundRect {
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    UIView *frontRect = [[UIView alloc] initWithFrame:CGRectMake (0, 0, 0, [self.charHeight integerValue])];
    frontRect.layer.masksToBounds = true;
    frontRect.layer.cornerRadius = chartCornerRadius;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frontRect.bounds;
    gradient.colors = @[(id)self.startColor.CGColor, (id)self.endColor.CGColor];
    [gradient setStartPoint:CGPointMake(0.0, 0.5)];
    [gradient setEndPoint:CGPointMake(1.0, 0.5)];
    [frontRect.layer insertSublayer:gradient atIndex:0];
    
    [self addSubview:frontRect];
}

- (void)animeCharRect {
    if (self.ratio == nil) {
        return;
    }
    UIView *frontRect = self.subviews.firstObject;
    CGFloat newWidth = self.frame.size.width * [self.ratio floatValue];
    [UIView animateWithDuration:1.5 animations:^(void) {
        [frontRect setFrame:CGRectMake(0, 0, newWidth, [self.charHeight integerValue])];
        [frontRect.layer.sublayers.firstObject setFrame:CGRectMake(0, 0, newWidth, [self.charHeight integerValue])];
    }];
}

@end
