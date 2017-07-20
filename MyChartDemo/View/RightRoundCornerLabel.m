//
//  RightRoundCornerLabel.m
//  MyChartDemo
//
//  Created by Ahri on 7/20/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "RightRoundCornerLabel.h"
#import "UIColor+RGB.h"

@implementation RightRoundCornerLabel

// load from nib
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

// custom init with frame
- (id)initWithFrame:(CGRect)aRect {
    if (self = [super initWithFrame:aRect]) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self customShadowForView];
    [self insertHalfRoundLabel];
}

- (void)customShadowForView {
    for (int i = 0; i < self.subviews.count; i++) {
        [self.subviews[i] removeFromSuperview];
    }
    
    self.backgroundColor = UIColor.clearColor;
    CGFloat radius = self.bounds.size.height / 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    [maskLayer setPath:path.CGPath];
    maskLayer.masksToBounds = true;
    self.layer.mask = maskLayer;
    
    // Add Shadow to UIView
    CGFloat leftMargin = 0.f;
    CGFloat topMargin = 0.4f;
    CGFloat rightMargin = 2.0f;
    CGFloat bottomMargin = 3.5f;
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, topMargin,
                                                                  self.frame.size.width - rightMargin,
                                                                  self.frame.size.height - bottomMargin)];
    shadowView.layer.masksToBounds = false;
    shadowView.backgroundColor = UIColor.clearColor;
    shadowView.layer.shadowColor = UIColor.grayColor.CGColor;
    shadowView.layer.shadowOpacity = 0.45f;
    shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    shadowView.layer.shadowRadius = 2.f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:shadowView.bounds];
    
    CGFloat labelRadius = label.bounds.size.height / 2;
    UIBezierPath *labelPath = [UIBezierPath bezierPathWithRoundedRect:label.bounds
                                               byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(labelRadius, labelRadius)];
    CAShapeLayer *labelMaskLayer = [CAShapeLayer layer];
    labelMaskLayer.frame = label.bounds;
    [labelMaskLayer setPath:labelPath.CGPath];
    label.layer.mask = labelMaskLayer;
    
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:UIColor.whiteColor];
    [label setText:@"Membership"];
    
    [shadowView addSubview:label];
    [self addSubview:shadowView];
}

- (void)insertHalfRoundLabel {
    
}

@end
