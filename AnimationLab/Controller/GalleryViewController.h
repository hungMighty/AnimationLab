//
//  GalleryViewController.h
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *localCollectionView;

@property (strong, nonatomic) NSMutableArray<NSString *> *imagesNames;

@end
