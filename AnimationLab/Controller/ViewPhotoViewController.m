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

// MARK: ImageTransitionProtocol

- (void)tranisitionSetup {
    self.bigImageView.hidden = true;
}

- (void)tranisitionCleanup {
    self.bigImageView.hidden = false;
}

- (CGRect)imageWindowFrame {
    return self.bigImageView.frame;
}

// MARK: - Actions

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)moreButtonPressed:(id)sender {
}


@end
