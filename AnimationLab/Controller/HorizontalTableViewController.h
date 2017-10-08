//
//  HorizontalTableViewController.h
//  AnimationLab
//
//  Created by Ahri on 10/8/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
