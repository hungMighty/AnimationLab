//
//  CustomRoundDisplayLabel.m
//  MyChartDemo
//
//  Created by Ahri on 7/18/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "CustomCircleLabel.h"
#import "UIColor+RGB.h"

@interface CustomCircleLabel () {
}

@end

@implementation CustomCircleLabel

// load from nib
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self customRoundShape];
    }
    return self;
}

// custom init with frame
- (id)initWithFrame:(CGRect)aRect {
    if (self = [super initWithFrame:aRect]) {
        [self customRoundShape];
    }
    return self;
}

- (void)customRoundShape {
    UIColor *labelDefaultColor = [UIColor rgb:176 green:36 blue:42];
    self.textColor = UIColor.whiteColor;
    self.textAlignment = NSTextAlignmentCenter;
    
    self.font = [UIFont systemFontOfSize:15.f weight:UIFontWeightMedium];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 3.0;
    self.layer.backgroundColor = labelDefaultColor.CGColor;
    self.layer.borderColor = labelDefaultColor.CGColor;
    
    self.translatesAutoresizingMaskIntoConstraints = false;
}

- (void)customLabelColor {
    if (self.labelThemeColor != nil) {
        self.layer.backgroundColor = self.labelThemeColor.CGColor;
        self.layer.borderColor = self.labelThemeColor.CGColor;
    }
    if (self.labelTextColor != nil) {
        self.textColor = self.labelTextColor;
    }
}

@end
