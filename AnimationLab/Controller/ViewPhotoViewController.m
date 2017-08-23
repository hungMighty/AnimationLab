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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
