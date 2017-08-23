//
//  AnimationController.m
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "FocusAnimationController.h"

@implementation FocusAnimationController

- (void)setupImageTransition:(UIImage *)image fromDelegate:(id<ImageTransitionProtocol> )fromDelegate toDelegate:(id<ImageTransitionProtocol>)toDelegate {
    self.image = image;
    self.fromDelegate = fromDelegate;
    self.toDelegate = toDelegate;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (containerView == nil || fromVC == nil || toVC == nil) {
        return;
    }
    
    toVC.view.frame = fromVC.view.frame;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = [self.fromDelegate imageWindowFrame];
    imageView.clipsToBounds = true;
    
    [self.fromDelegate tranisitionSetup];
    [self.toDelegate tranisitionSetup];
    
    UIView *fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:true];
    fromSnapshot.frame = fromVC.view.frame;
    [containerView addSubview:fromSnapshot];
    
    UIView *toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:true];
    toSnapshot.frame = toVC.view.frame;
    [containerView addSubview:toSnapshot];
    toSnapshot.alpha = 0;
    
    [containerView bringSubviewToFront:imageView];
    CGRect toFrame = [self.toDelegate imageWindowFrame];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0
         usingSpringWithDamping:0.85 initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         toSnapshot.alpha = 1;
                         imageView.frame = toFrame;
                     }
                     completion:^(BOOL finished) {
                         [self.fromDelegate tranisitionCleanup];
                         [self.toDelegate tranisitionCleanup];
                         
                         [imageView removeFromSuperview];
                         [fromSnapshot removeFromSuperview];
                         [toSnapshot removeFromSuperview];
                         
                         if (!transitionContext.transitionWasCancelled) {
                             [containerView addSubview:toVC.view];
                         }
                         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                     }];
}

@end
