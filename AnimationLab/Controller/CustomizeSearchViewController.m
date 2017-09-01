//
//  CustomizeSearchViewController.m
//  AnimationLab
//
//  Created by Ahri on 9/1/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "CustomizeSearchViewController.h"

@interface CustomizeSearchViewController ()

@end

@implementation CustomizeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBarTintColor:[UIColor redNavigationColor]];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: UIColor.whiteColor }];
    self.title = @"Customize Search Bar";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customizeSearchbar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setTintColor:[UIColor blackColor]];
    [navBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: UIColor.blackColor }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeSearchbar {
    [self.searchBar setPlaceholder:@"Search..."];
    [self.searchBar setBarTintColor:[UIColor redNavigationColor]];
}

// MARK - Actions

// MARK - SearchBar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:true animated:true];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.text = @"";
    [self.searchBar setShowsCancelButton:false animated:true];
    [self.searchBar resignFirstResponder];
}

@end
