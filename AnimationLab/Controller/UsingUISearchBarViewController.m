//
//  CustomizeSearchViewController.m
//  AnimationLab
//
//  Created by Ahri on 9/1/17.
//  Copyright © 2017 Bloomer. All rights reserved.
//

#import "UsingUISearchBarViewController.h"
#import "SimpleTableCell.h"

@interface UsingUISearchBarViewController () {
    NSMutableArray *gamesData;
    NSMutableArray *filteredData;
    BOOL searchActive;
    NSIndexPath *lastRowIndex;
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
    
    gamesData = [[NSMutableArray alloc] initWithObjects:@"Nier Automata", @"Crash Bandicoot", @"Neighbors from Hell",
                 @"Age of Empire 3", @"Dota 2", @"League of Legends", @"The Sims 4", @"Need for Speed",
                 @"Resident Evil", @"Diablo 3", @"Hearthstone", @"Overwatch",
                 @"Days Gone", @"Mario", @"Just Dance", @"Blade & Soul", nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:[SimpleTableCell cellIdentifier] bundle:nil]
         forCellReuseIdentifier:[SimpleTableCell cellIdentifier]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self customizeSearchbar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UINavigationBar *navBar = [self.navigationController navigationBar];
    [navBar setBarTintColor:[UIColor whiteColor]];
    [navBar setTintColor:[UIColor blackColor]];
    [navBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: UIColor.blackColor }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
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
    if (searchActive == true) {
        return filteredData.count;
    }
    return gamesData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SimpleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[SimpleTableCell cellIdentifier] forIndexPath:indexPath];
    if (searchActive == true && indexPath.row < filteredData.count) {
        cell.contentLabel.text = filteredData[indexPath.row];
    } else if (indexPath.row < gamesData.count) {
        cell.contentLabel.text = gamesData[indexPath.row];
    }
    
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
    searchActive = false;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchActive = false;
    self.searchBar.text = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    [self.searchBar setShowsCancelButton:false animated:true];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchActive = false;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    filteredData = [[NSMutableArray alloc] init];
    if ([searchText isEqualToString:@""]) {
        searchActive = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        return;
    }
    
    for (int i = 0; i <gamesData.count; i++) {
        NSString *str = gamesData[i];
        if ([[str lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) {
            [filteredData addObject:str];
        }
    }
    searchActive = true;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

// MARK - Keyboard Observer

- (void)keyboardWillShow:(NSNotification *)noti {
    NSArray *visibleIndexes = [self.tableView indexPathsForVisibleRows];
    lastRowIndex = visibleIndexes.lastObject;
}

- (void)keyboardDidShow:(NSNotification *)noti {
    NSDictionary *keyboardInfo = [noti userInfo];
    CGRect keyboardRect = [[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableViewBottomSpaceConstraint.constant = keyboardRect.size.height;
        [self.tableView layoutIfNeeded];
        
        if (lastRowIndex != nil) {
            [self.tableView scrollToRowAtIndexPath:lastRowIndex atScrollPosition:UITableViewScrollPositionBottom animated:true];
        }
    });
}

- (void)keyboardDidHide:(NSNotification *)noti {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableViewBottomSpaceConstraint.constant = 0;
    });
}

@end
