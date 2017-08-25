//
//  ViewPhotoViewController.m
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "ViewPhotoViewController.h"

@interface ViewPhotoViewController ()

@end

@implementation ViewPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.bigImageView.image = [UIImage imageNamed:self.bigImageName];
    
    self.titleLabel.textColor = UIColor.whiteColor;
    [self colorButton:self.backButton];
    [self colorButton:self.moreButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Styling methods

- (void)colorButton:(UIButton *)button {
    UIImage *tintableImage = [[button backgroundImageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setBackgroundImage:tintableImage forState:UIControlStateNormal];
    button.tintColor = UIColor.whiteColor;
}

// MARK: - Actions

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)moreButtonPressed:(id)sender {
}

// MARK: - <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.bigImageView.image];
    imageView.contentMode = self.bigImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = self.bigImageView.frame;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor {
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGRect frame = self.bigImageView.frame;
    frame.size.width = width;
    return frame;
}

// MARK: - <RMPZoomTransitionDelegate>

- (void)zoomTransitionAnimator:(RMPZoomTransitionAnimator *)animator
         didCompleteTransition:(BOOL)didComplete
      animatingSourceImageView:(UIImageView *)imageView {
    self.bigImageView.image = imageView.image;
}

@end
