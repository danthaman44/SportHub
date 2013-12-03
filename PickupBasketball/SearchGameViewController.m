//
//  SecondViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SearchGameViewController.h"
#import "GameDetailViewController.h"

@interface SearchGameViewController ()

@end

@implementation SearchGameViewController
{
    NSArray *locations;
    NSArray *times;
    NSArray *Ids;
    NSArray *playerCounts;
    NSArray *searchResults;
}
@synthesize mainTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locations = [NSArray arrayWithObjects:@"Wilson", @"Brodie", @"Central", nil];
    times = [NSArray arrayWithObjects:@"5:00", @"6:00", @"7:00", nil];
    playerCounts = [NSArray arrayWithObjects:@"5", @"9", @"4", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [locations count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"GameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [locations objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [locations filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGameDetail"]) {
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        GameDetailViewController *destViewController = segue.destinationViewController;
        destViewController.location = [locations objectAtIndex:indexPath.row];
        destViewController.time = [times objectAtIndex:indexPath.row];
        destViewController.numPlayers = [playerCounts objectAtIndex:indexPath.row];
    }
}



@end
