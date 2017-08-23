//
//  AnimationController.h
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageTransitionProtocol <NSObject>
- (void)tranisitionSetup;
- (void)tranisitionCleanup;
- (CGRect)imageWindowFrame;
@end

@interface FocusAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<ImageTransitionProtocol> fromDelegate;
@property (nonatomic, weak) id<ImageTransitionProtocol> toDelegate;
@property (nonatomic, weak) UIImage *image;

- (void)setupImageTransition:(UIImage *)image fromDelegate:(id<ImageTransitionProtocol> )fromDelegate toDelegate:(id<ImageTransitionProtocol>)toDelegate;

@end
