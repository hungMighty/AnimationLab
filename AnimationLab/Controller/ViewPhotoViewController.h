//
//  ViewPhotoViewController.h
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPZoomTransitionAnimator.h"

@interface ViewPhotoViewController : UIViewController <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (assign, nonatomic) NSString *bigImageName;

@end
