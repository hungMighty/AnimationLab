//
//  GalleryViewController.m
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "GalleryViewController.h"
#import "SimpleCollectionCell.h"
#import "ViewPhotoViewController.h"

@interface GalleryViewController () {
    UIEdgeInsets sectionInsets;
    int itemsPerRow;
    int selectedIndex;
    BOOL hideSelectedCell;
    NSMutableArray<UIImage *> *allPhotos;
}

@end

@implementation GalleryViewController

@synthesize imagesNames;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:[SimpleCollectionCell nibName] bundle:nil]
               forCellWithReuseIdentifier:[SimpleCollectionCell cellIdentifier]];
    self.imagesNames = [[NSMutableArray alloc] initWithObjects:@"(x) Ahri",
                        @"Battle 2B", @"Star Guardian Ahri",
                        @"Star Guardian Syndra", @"Young Gothic", nil];
    for (int i = 0; i < self.imagesNames.count; i++) {
        imagesNames[i] = [imagesNames[i] stringByAppendingString:@".jpg"];
    }
    [imagesNames addObject:@"Guilty Pleasure"];
    
    sectionInsets = UIEdgeInsetsMake(50, 20, 50, 20);
    itemsPerRow = 3;
    hideSelectedCell = false;
    
    allPhotos = [[NSMutableArray alloc] init];
    for (int i = 0; i < imagesNames.count; i++) {
        [allPhotos addObject:[UIImage imageNamed:self.imagesNames[i]]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewSelectedPhotoWithName:(NSString *)name {
    ViewPhotoViewController *view = [[ViewPhotoViewController alloc] init];
    view.bigImageName = name;
    view.transitioningDelegate = self;
    [self presentViewController:view animated:true completion:nil];
}

// MARK: - CollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SimpleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SimpleCollectionCell cellIdentifier] forIndexPath:indexPath];
    cell.cellImageView.backgroundColor = UIColor.blackColor;
    cell.cellImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImage *setImage = allPhotos[indexPath.row];
    if (hideSelectedCell && indexPath.row == selectedIndex) {
        setImage = nil;
    }
    cell.cellImageView.image = setImage;
    
    return cell;
}

// MARK: - CollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat totalPaddingSpace = sectionInsets.left * (itemsPerRow + 1);
    CGFloat widthPerItem = (self.view.frame.size.width - totalPaddingSpace) / itemsPerRow;
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return sectionInsets.left;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = (int)indexPath.row;
    [self viewSelectedPhotoWithName:self.imagesNames[indexPath.row]];
}

// MARK: - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)source;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)dismissed;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)self;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

// MARK: - <RMPZoomTransitionAnimating> Implementation

- (UIImageView *)transitionSourceImageView {
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    SimpleCollectionCell *cell = (SimpleCollectionCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.cellImageView.image];
    imageView.contentMode = cell.cellImageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.cellImageView convertRect:cell.cellImageView.frame toView:self.view.window];
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor {
    return self.collectionView.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame {
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    SimpleCollectionCell *cell = (SimpleCollectionCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
//    CGRect cellFrameInSuperview = [self.view.window convertRect:cell.cellImageView.frame fromView:cell.cellImageView];
    CGRect cellFrameInSuperview = [cell.cellImageView convertRect:cell.cellImageView.bounds toView:self.view.window];
    return cellFrameInSuperview;
}

@end
