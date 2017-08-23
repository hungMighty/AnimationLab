//
//  GalleryViewController.m
//  AnimationLab
//
//  Created by Ahri on 8/23/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "GalleryViewController.h"
#import "SimpleCollectionCell.h"

@interface GalleryViewController ()

@end

@implementation GalleryViewController

@synthesize imagesNames;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.localCollectionView registerNib:[UINib nibWithNibName:[SimpleCollectionCell nibName] bundle:nil]
               forCellWithReuseIdentifier:[SimpleCollectionCell cellIdentifier]];
    self.imagesNames = [[NSMutableArray alloc] initWithObjects:@"(x) Ahri",
                        @"Battle 2B", @"Guilty Pleasure", @"Star Guardian Ahri",
                        @"Star Guardian Syndra", @"Young Gothic", nil];
    for (int i = 0; i < self.imagesNames.count; i++) {
        [imagesNames[i] stringByAppendingString:@".jpg"];
    }
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
    cell.cellImageView.backgroundColor = UIColor.cyanColor;
    cell.cellImageView.image = [UIImage imageNamed:self.imagesNames[indexPath.row]];
    
    return cell;
}


// MARK: - CollectionView Delegate

@end
