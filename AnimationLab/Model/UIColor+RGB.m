//
//  UIColor+RGB.m
//  MyChartDemo
//
//  Created by Ahri on 7/13/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

// MARK: - Parsing Colors

+ (UIColor *)rgb:(int)red green:(int)green blue:(int)blue {
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

+ (UIColor*)colorWithHex:(int)hex {
    return UIColorFromRGB(hex);
}

// MARK: - Global Colors

+ (UIColor *)redNavigationColor {
    return [UIColor rgb:176 green:36 blue:41];
}

@end
