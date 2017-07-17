//
//  ValueLabelForBarchart.m
//  MyChartDemo
//
//  Created by Ahri on 7/14/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ValueLabelForBarchart.h"

@implementation ValueLabelForBarchart

// load from nib
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addCustomUILabelWithShadow];
    }
    return self;
}

// custom init with frame
- (id)initWithFrame:(CGRect)aRect {
    if (self = [super initWithFrame:aRect]) {
        [self addCustomUILabelWithShadow];
    }
    return self;
}

- (void)addCustomUILabelWithShadow {
    if (self.barChartValues == nil) {
        return;
    }
    for (int i = 0; i < self.subviews.count; i++) {
        [self.subviews[i] removeFromSuperview];
    }
    
    // Add Shadow to bar chart
    CGFloat subViewOffset = 0.5f;
    CGFloat labelMargin = 3.f;
    CGRect superViewBounds = self.frame;
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(subViewOffset, subViewOffset,
                                                                  superViewBounds.size.width - labelMargin,
                                                                  superViewBounds.size.height - labelMargin)];
    shadowView.layer.masksToBounds = false;
    shadowView.backgroundColor = UIColor.clearColor;
    shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
    shadowView.layer.shadowOpacity = 0.2f;
    shadowView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    shadowView.layer.shadowRadius = 1.5f;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(subViewOffset, subViewOffset,
                                                                          superViewBounds.size.width - labelMargin,
                                                                          superViewBounds.size.height - labelMargin)];
    valueLabel.backgroundColor = UIColor.whiteColor;
    valueLabel.layer.masksToBounds = true;
    valueLabel.layer.cornerRadius = valueLabel.frame.size.height / 2;
    
    [shadowView addSubview:valueLabel];
    [self addSubview:shadowView];
    [self setBackgroundColor:UIColor.clearColor];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = valueLabel.frame.size.height / 2;
}

- (void)setValueWithColorForLabel {
    if (self.barChartValues == nil) {
        return;
    }
    UILabel *valueLabel = (UILabel *) self.subviews[0].subviews[0];
    if (valueLabel && self.barChartValues.count > 0) {
        [valueLabel setFont:[UIFont systemFontOfSize:13.f weight:UIFontWeightRegular]];
        [valueLabel setTextAlignment:NSTextAlignmentCenter];
        NSMutableAttributedString *text;
        UIColor *textColor;
        if (self.barChartValues.count == 2) {
            [valueLabel setText:[NSString stringWithFormat:@"%li / %li",
                                 (long)[self.barChartValues[0] integerValue],
                                 (long)[self.barChartValues[1] integerValue]]];
            
            text = [[NSMutableAttributedString alloc] initWithAttributedString: valueLabel.attributedText];
            textColor = [UIColor rgb:174 green:14 blue:25];
        } else {
            [valueLabel setText:[NSString stringWithFormat:@"%li",
                                 (long)[self.barChartValues[0] integerValue]]];
            text = [[NSMutableAttributedString alloc] initWithAttributedString: valueLabel.attributedText];
            textColor = [UIColor rgb:139 green:139 blue:139];
        }
        [text addAttribute:NSForegroundColorAttributeName
                     value:textColor
                     range:NSMakeRange(0, 1)];
        [valueLabel setAttributedText: text];
    }
}

@end
