//
//  HorizontalTableViewController.m
//  AnimationLab
//
//  Created by Ahri on 10/8/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "HorizontalTableViewController.h"
#import "HorizontalTableViewCell.h"
#import "SimpleCollectionCell.h"

@interface HorizontalTableViewController () {
    CGFloat tableCellHeight;
}

@end

@implementation HorizontalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableCellHeight = 150;
    [self.tableView registerNib:[UINib nibWithNibName:[HorizontalTableViewCell cellIdentifier]
                                               bundle:nil]
         forCellReuseIdentifier:[HorizontalTableViewCell cellIdentifier]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HorizontalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HorizontalTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.collectionView.dataSource = self;
    cell.collectionView.delegate = self;
    [cell.collectionView registerNib:[UINib nibWithNibName:[SimpleCollectionCell cellIdentifier] bundle:nil] forCellWithReuseIdentifier:[SimpleCollectionCell cellIdentifier]];
    
    return cell;
}

// MARK: - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(tableCellHeight, tableCellHeight);
}

// MARK: - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SimpleCollectionCell cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}

// MARK: - Actions


@end
