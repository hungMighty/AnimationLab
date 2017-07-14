//
//  ValueLabelForBarchart.h
//  MyChartDemo
//
//  Created by Ahri on 7/14/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilityClasses.h"

@interface ValueLabelForBarchart : UIView

@property (weak, nonatomic) NSMutableArray<NSNumber *> *barChartValues;

- (void)addCustomUILabelWithShadow;

@end
