//
//  UIColor+RGB.m
//  MyChartDemo
//
//  Created by Ahri on 7/13/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (UIColor *)rgb:(int)red green:(int)green blue:(int)blue {
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

@end
