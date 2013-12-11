//
//  SecondViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//  Authors: Matt Parides & Wei Deng

#import "SearchGameViewController.h"
#import "GameDetailViewController.h"
#import "CJSONDeserializer.h"
#import "LoggedInUser.h"

@interface SearchGameViewController ()

@end

@implementation SearchGameViewController
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    locations = [NSArray arrayWithObjects:@"Wilson", @"Brodie", @"Central", @"Brodie",nil];
//    times = [NSArray arrayWithObjects:@"5:00", @"6:00", @"7:00", @"8:00", nil];
//    playerCounts = [NSArray arrayWithObjects:@"5", @"9", @"4", @"3", nil];
    _games = [[NSArray alloc] init];
    _privateGames = [[NSArray alloc] init];
    _searchResults = [[NSArray alloc] init];

}
- (void)viewDidAppear:(BOOL)animated {
    NSString *serverAddress = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/see_games"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"POST"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSError *theError = nil;
    NSArray* jsonData = [[CJSONDeserializer deserializer] deserialize:response error:&theError];
    NSMutableArray* tempGames = [[NSMutableArray alloc] init];
    NSMutableArray* tempPrivateGames = [[NSMutableArray alloc] init];
    if ([jsonData count] > 0) {
        for (NSArray* object in jsonData) {
            Game *g1 = [[Game alloc] init];
            NSMutableArray *playersTemp = [[NSMutableArray alloc] init];
            if([object objectAtIndex:7] != nil) {
                for (NSString* player in [object objectAtIndex:7]) {
                    [playersTemp addObject:player];
                }
            }
            g1.players = playersTemp;
            g1.gid = [[object objectAtIndex:6] intValue];
            g1.numPlayers = 3;
            g1.location = [object objectAtIndex:1];
            NSString *str =[object objectAtIndex:2];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [formatter dateFromString:str];
            g1.time = date;
            g1.sport = [object objectAtIndex:3];
            g1.isPrivate = [object objectAtIndex:5];
            g1.numPlayers = [[object objectAtIndex:4] intValue];
            
            if([g1.isPrivate isEqualToString:@"True"]) {
                [tempPrivateGames addObject:g1];
            }
            else {
                [tempGames addObject:g1];
            }
        }
    }
    self.games = [NSArray arrayWithArray:tempGames];
    self.privateGames = [NSArray arrayWithArray:tempPrivateGames];
    [self.mainTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        self.selectedGame = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        self.selectedGame = [self.games objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"GameViewSeg" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameDetailViewController* next = segue.destinationViewController;
    next.gameId = self.selectedGame.gid;
    next.time = self.selectedGame.time;
    next.location =  self.selectedGame.location;
    next.numPlayers = self.selectedGame.numPlayers;
    next.sport = self.selectedGame.sport;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Games";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else {
        //NSLog(@"%d", [self.games count]);
        return [self.games count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"GameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Game* g = [[Game alloc]init];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        g =(Game*)[self.searchResults objectAtIndex:indexPath.row];
    }
    else {
        g = [self.games objectAtIndex:indexPath.row];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *time = [dateFormatter stringFromDate:g.time];
    NSString *location = g.location;
    NSString *cellValue = [NSString stringWithFormat: @"%@ - %@ - %@", time, location, g.sport];
    cell.textLabel.text = cellValue;
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:g.time];
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.sport contains[cd] %@",
                                    searchText];
    
    self.searchResults = [self.games filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}


@end
