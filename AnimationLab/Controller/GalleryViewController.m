//
//  GalleryViewController.m
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "GalleryViewController.h"
#import "SimpleCollectionCell.h"

@interface GalleryViewController () {
    UIEdgeInsets sectionInsets;
    int itemsPerRow;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.cellImageView.image = [UIImage imageNamed:self.imagesNames[indexPath.row]];
    
    return cell;
}

// MARK: - CollectionView Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat totalPaddingSpace = sectionInsets.left * (itemsPerRow + 1);
    CGFloat widthPerItem = (self.view.frame.size.width - totalPaddingSpace) / itemsPerRow;
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return sectionInsets.left;
}

@end
