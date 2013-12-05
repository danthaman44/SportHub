//
//  SecondViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SearchGameViewController.h"
#import "GameDetailViewController.h"
#import "Game.h"
#import "CJSONDeserializer.h"

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
    _games = [[NSMutableArray alloc] init];
    _privateGames = [[NSMutableArray alloc] init];

}
- (void)viewDidAppear:(BOOL)animated {
    _searchResults = [[NSArray alloc] init];
    NSString *serverAddress = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/see_games"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"POST"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString *responseBody = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //NSError *e;
    //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseBody options:nil error:&e];
    //for(id key in dict) {
    //   NSLog(@"key=%@ value=%@", key, [dict objectForKey:key]);
    // }
    NSError *theError = nil;
    NSArray* jsonData = [[CJSONDeserializer deserializer] deserialize:response error:&theError];
    //  NSMutableArray *allGames = [NSMutableArray array];
    
    for (NSArray* object in jsonData) {
        Game *g1 = [[Game alloc] init];
        NSMutableArray *playersTemp = [[NSMutableArray alloc] init];
        for (NSString* player in [object objectAtIndex:7]) {
            [playersTemp addObject:player];
        }
        g1.players = playersTemp;
        g1.id = [object objectAtIndex:6];
        g1.numPlayers = 3;
        g1.location = [object objectAtIndex:1];
        NSString *str =[object objectAtIndex:2];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [formatter dateFromString:str];
        g1.time = date;
        g1.sport = [object objectAtIndex:3];
        g1.isPrivate = [object objectAtIndex:5];
        g1.numPlayers = [object objectAtIndex:4];
        
        if(g1.isPrivate) {
            [self.privateGames addObject:g1];
        }
        else {
            [self.games addObject:g1];
        }
        NSLog(@"%@", g1.players);
        
    }
<<<<<<< HEAD
    NSLog(@"response: ");
    NSLog(responseBody);
=======

//    NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
//    for (int i =0; i < [jsonArray count]; i++ ) {
//        NSArray *gameInfo = [jsonArray objectAtIndex:i];
//        for (int k =0; k < [gameInfo count]; i++ ) {
//            NSLog([gameInfo objectAtIndex:i]);
//        }
//        
//    }

>>>>>>> 43a4e1ccdb9e6e166df046491cc03c58bc9f0f0e
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.games count];
        
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
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        Game *g = [self.games objectAtIndex:indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *time = [dateFormatter stringFromDate:g.time];
        NSString *location = g.location;
        NSString *cellValue = [NSString stringWithFormat: @"%@ %@ %@", time, @" - ", location];
        cell.textLabel.text = cellValue;
        return cell;
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.location contains[cd] %@",
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGameDetail"]) {
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        GameDetailViewController *destViewController = segue.destinationViewController;
        Game *main = [self.games objectAtIndex:indexPath.row];
        destViewController.location = main.location;
        destViewController.time = main.time;
        destViewController.numPlayers = main.numPlayers;
    }
}

-(IBAction)privateGameSearch:(id)sender {
    for(Game* game in self.privateGames) {
        if(game.id == [self.privateSearch.text intValue]) {
            
        }
    }
}

-(IBAction)resignFirst:(id)sender {
    [sender resignFirstResponder];
}



@end
