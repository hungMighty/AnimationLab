//
//  GalleryViewController.h
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusAnimationController.h"

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate,
ImageTransitionProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray<NSString *> *imagesNames;

@end
