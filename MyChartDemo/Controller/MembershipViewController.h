//
//  MembershipViewController.h
//  MyChartDemo
//
//  Created by Ahri on 7/12/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MembershipViewController : ViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray<NSNumber *> *bronzeBarChartValues;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *silverBarChartValues;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *goldBarChartValues;

@end
