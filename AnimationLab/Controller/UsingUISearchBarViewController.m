//
//  CustomizeSearchViewController.m
//  AnimationLab
//
//  Created by Ahri on 9/1/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "UsingUISearchBarViewController.h"
#import "CityCell.h"

@interface UsingUISearchBarViewController () {
    NSMutableArray *gamesData;
    NSMutableArray *filteredResults;
}

@end

@implementation UsingUISearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBarTintColor:[UIColor redNavigationColor]];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: UIColor.whiteColor }];
    self.title = @"Customize Search Bar";
    
    gamesData = @[
                  @"Nier Automata", @"Crash Bandicoot", @"Neighbors from Hell", @"Age of Empire 3", @"Dota 2", @"League of Legends", @"The Sims 4", @"Need for Speed",
                  @"Resident Evil", @"Diablo 3", @"Hearthstone", @"Overwatch"
                  ];
    
    [self.tableView registerNib:[UINib nibWithNibName:[CityCell cellIdentifier]
                                               bundle:nil]
         forCellReuseIdentifier:[CityCell cellIdentifier]];
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

// MARK - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gamesData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:[CityCell cellIdentifier] forIndexPath:indexPath];
    cell.contentLabel.text = gamesData[indexPath.row];
    
    return cell;
}

// MARK - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
