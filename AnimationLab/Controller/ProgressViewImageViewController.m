//
//  ProgressViewImageViewController.m
//  AnimationLab
//
//  Created by Ahri on 9/25/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ProgressViewImageViewController.h"
#import "WeakLinkObj.h"
#import "UIColor+RGB.h"

#define PROGRESS_KEY @"progressObj"
#define TOTAL_TIME_KEY @"totalTime"
#define REMAIN_TIME_KEY @"remainTime"
#define IMAGE_INDEX_KEY @"imageIndex"

@interface ProgressViewImageViewController () {
    NSMutableArray<NSString *> *imageNames;
    NSMutableArray<UIImageView *> *imageViews;
    NSMutableArray<NSTimer *> *myTimers;
}

@end

@implementation ProgressViewImageViewController

- (void)dealloc {
    NSLog(@"ProgressViewImageViewController dealloc");
    
    for (int i = 0; i < myTimers.count; i++) {
        NSTimer *timerObj = myTimers[i];
        [timerObj invalidate];
        timerObj = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Progress Gallery";
    myTimers = [[NSMutableArray alloc] init];
    imageNames = [[NSMutableArray alloc] initWithObjects:@"(x) Ahri icon.jpg", @"Ahri without Glasses", @"Jack-O icon",
                  @"(x) Jinx Avatar", @"Jax", @"Kawaii Annie"
                  , @"Ahri's Peko", @"Cute Ahri", @"Yuzuruha Avatar", nil];
    imageViews = [[NSMutableArray alloc] initWithObjects:self.firstImageView, self.secondImageView, self.thirdImageView,
                  self.fourthImageView, self.fifthImageView, self.sixthImageView,
                  self.seventhImageView, self.eighthImageView, self.ninthImageView, nil];
    for (int i = 0; i < imageViews.count; i++) {
        imageViews[i].backgroundColor = [UIColor rgb:230 green:230 blue:230];
        imageViews[i].layer.cornerRadius = 10;
        imageViews[i].layer.masksToBounds = true;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i = 0; i < imageViews.count; i++) {
        imageViews[i].contentMode = UIViewContentModeScaleAspectFill;
    }
    
    for (int i = 0; i < imageViews.count; i++) {
        CGRect imageViewBounds = imageViews[i].bounds;
        CGRect progressViewFrame = CGRectMake(5, (imageViewBounds.size.height - 4) / 2,
                                              (imageViewBounds.size.width - 5 * 2), 4);
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:progressViewFrame];
        [progressView setTransform:CGAffineTransformMakeScale(1.0, 2.0)];
        progressView.layer.masksToBounds = true;
        progressView.layer.cornerRadius = 10;
        progressView.trackTintColor = [UIColor rgb:240 green:245 blue:255];
        progressView.tintColor = [UIColor rgb:0 green:191 blue:255];
        [imageViews[i] addSubview:progressView];
        
        double randomTime = 1 + arc4random() % (7 - 1);
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        userInfo[PROGRESS_KEY] = progressView;
        userInfo[TOTAL_TIME_KEY] = @(randomTime);
        userInfo[REMAIN_TIME_KEY] = @(randomTime);
        userInfo[IMAGE_INDEX_KEY] = @(i);
        
        NSTimer *tempTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                         target:[WeakLinkObj weakObjectWithRealTarget:self]
                                       selector:@selector(updateProgress:)
                                       userInfo:userInfo
                                        repeats:true];
        [myTimers addObject:tempTimer];
    }
}

- (void)updateProgress:(NSTimer *)theTimer {
    NSMutableDictionary *userInfo = [theTimer userInfo];
    UIProgressView *progressView = (UIProgressView *)userInfo[PROGRESS_KEY];
    double totalTime = [(NSNumber *)userInfo[TOTAL_TIME_KEY] doubleValue];
    double remainTime = [(NSNumber *)userInfo[REMAIN_TIME_KEY] doubleValue];
    
    if (remainTime < 0) {
        progressView.progress = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [progressView removeFromSuperview];
            int imageIndex = [(NSNumber *)userInfo[IMAGE_INDEX_KEY] intValue];
            imageViews[imageIndex].image = [UIImage imageNamed:imageNames[imageIndex]];
        });
        
        [theTimer invalidate];
        theTimer = nil;
    } else {
        progressView.progress = (totalTime - remainTime) / totalTime;
        userInfo[@"remainTime"] = @(remainTime - 0.1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
