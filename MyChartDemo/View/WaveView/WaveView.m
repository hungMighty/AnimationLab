//
//  WaveView.m
//  MyChartDemo
//
//  Created by Ahri on 7/21/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "WaveView.h"
#import "WeakLinkObj.h"

@interface WaveView () {
    
}

@property (assign, nonatomic) CGFloat offsetX;
@property (strong, nonatomic) CADisplayLink *waveDisplayLink;
@property (strong, nonatomic) CAShapeLayer *waveShapeLayer;

@end

@implementation WaveView

- (void)dealloc {
    [self.waveDisplayLink invalidate];
    self.waveDisplayLink = nil;
}

+ (instancetype)addToView:(UIView *)view withFrame:(CGRect)frame {
    WaveView *wave = [[self alloc] initWithFrame:frame];
    [view addSubview:wave];
    return wave;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self basicSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if ([super initWithCoder:aDecoder]) {
        [self basicSetup];
    }
    return self;
}

- (void)basicSetup {
    self.angularSpeed = 2.f;
    self.waveSpeed = 9.f;
    self.waveTime = 1.5f;
    self.waveColor = [UIColor whiteColor];
}

- (BOOL)wave {
    if (self.waveShapeLayer.path) {
        return false;
    }
    
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:[WeakLinkObj weakObjectWithRealTarget:self]
                                                       selector:@selector(currentWave)];
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (self.waveTime != -1.f && self.waveTime > 0.f) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.waveTime * NSEC_PER_SEC))
                       , dispatch_get_main_queue(),
                       ^{
                           [self stop];
                       });
    }
    return true;
}

- (void)currentWave {
    self.offsetX -= (self.waveSpeed * self.superview.frame.size.width / 320);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, height / 2);
    
    CGFloat y = 0.f;
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sin(0.01 * (self.angularSpeed * x + self.offsetX));
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, width, height);
    CGPathAddLineToPoint(path, nil, 0, height);
    CGPathCloseSubpath(path);
    self.waveShapeLayer.path = path;
    CGPathRelease(path);
}

- (void)stop {
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.waveDisplayLink invalidate];
        self.waveDisplayLink = nil;
        self.waveShapeLayer.path = nil;
        self.alpha = 1.f;
    }];
}


@end
