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
    [valueLabel setText:[NSString stringWithFormat:@"%li / %li",
                               (long)[self.barChartValues[0] integerValue], (long)[self.barChartValues[1] integerValue]]];
    [valueLabel setFont:[UIFont systemFontOfSize:14.f]];
    [valueLabel setTextAlignment:NSTextAlignmentCenter];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: valueLabel.attributedText];
    UIColor *textColor = [UIColor rgb:174 green:14 blue:25];
    [text addAttribute:NSForegroundColorAttributeName
                 value:textColor
                 range:NSMakeRange(0, 1)];
    [valueLabel setAttributedText: text];
    valueLabel.backgroundColor = UIColor.whiteColor;
    valueLabel.layer.masksToBounds = true;
    valueLabel.layer.cornerRadius = valueLabel.frame.size.height / 2;
    
    [shadowView addSubview:valueLabel];
    [self addSubview:shadowView];
    [self setBackgroundColor:UIColor.clearColor];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = valueLabel.frame.size.height / 2;
}

@end
