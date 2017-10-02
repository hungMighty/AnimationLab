//
//  TableWithHeaderImageScaleViewController.m
//  AnimationLab
//
//  Created by Ahri on 10/2/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "TableWithHeaderImageScaleViewController.h"
#import "SimpleTableCell.h"

@interface TableWithHeaderImageScaleViewController () {
    UIImageView *ahriImage;
}

@end

@implementation TableWithHeaderImageScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Table with Stretchable Image Header";
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleTableCell" bundle:nil] forCellReuseIdentifier:@"SimpleTableCell"];
    self.tableView.estimatedRowHeight = 50;
    [self.tableView setContentInset:UIEdgeInsetsMake(300, 0, 0, 0)];
    ahriImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"(x) Ahri.jpg"]];
    ahriImage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
    ahriImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:ahriImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 65;
    }
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[SimpleTableCell cellIdentifier] forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        cell.contentLabel.text = @"This is very long header and it is used for demo purpose";
        cell.backgroundColor = UIColor.blackColor;
        cell.contentLabel.textColor = UIColor.whiteColor;
    } else {
        cell.contentLabel.text = @"This is very long content and it is also used for demo purpose. However, it just does not end here. There is so many things to display within this label that no one dare to read it.";
        cell.backgroundColor = UIColor.whiteColor;
        cell.contentLabel.textColor = UIColor.blackColor;
    }
    
    return cell;
}

// MARK - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

// MARK - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Start from negative
    CGFloat offset = 300 - (300 + scrollView.contentOffset.y);
    CGFloat newHeight = MIN(MAX(offset, 40), 400);
    ahriImage.frame = CGRectMake(0, 0, self.view.frame.size.width, newHeight);
}

// MARK - Actions

@end
