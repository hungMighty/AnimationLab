//
//  CustomizeSearchViewController.h
//  AnimationLab
//
//  Created by Ahri on 9/1/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RGB.h"

@interface UsingUISearchBarViewController : UIViewController <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
