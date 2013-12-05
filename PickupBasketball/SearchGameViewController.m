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

@interface SearchGameViewController ()

@end

@implementation SearchGameViewController
{
    NSArray *locations;
    NSArray *times;
    NSArray *Ids;
    NSArray *playerCounts;
    NSArray *searchResults;
    NSArray *games;
}
@synthesize mainTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locations = [NSArray arrayWithObjects:@"Wilson", @"Brodie", @"Central", @"Brodie",nil];
    times = [NSArray arrayWithObjects:@"5:00", @"6:00", @"7:00", @"8:00", nil];
    playerCounts = [NSArray arrayWithObjects:@"5", @"9", @"4", @"3", nil];
    
    NSString *serverAddress = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/see_games"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
   [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString *responseBody = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"response: ");
    NSLog(responseBody);
    
    
    NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
    for (int i =0; i < [jsonArray count]; i++ ) {
        NSArray *gameInfo = [jsonArray objectAtIndex:i];
        for (int k =0; k < [gameInfo count]; i++ ) {
            NSLog([gameInfo objectAtIndex:i]);
        }
        
    }


    

    //==============================================================================
    //parsing JSON data
//    
//    NSError *localError = nil;
//    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:response options:0 error:&localError];
    
//    if (localError != nil) {
//        *error = localError;
//        return nil;
//    }
//    
//    NSMutableArray *gamesFromServer = [[NSMutableArray alloc] init];
//    
//    NSArray *results = [parsedObject valueForKey:@"results"];
//    NSLog(@"Count %d", results.count);
//    
//    for (NSDictionary *groupDic in results) {
//        //Game *game = [[Game alloc] init];
//        
//        for (NSString *key in groupDic) {
//            NSLog(key);
//            if ([game respondsToSelector:NSSelectorFromString(key)]) {
//                [game setValue:[groupDic valueForKey:key] forKey:key];
//            }
//        }
        
//        [gamesFromServer addObject:game];
//    }
//    
//    return groups;
    
    
    
    
    
    
    
    
    
    
    
    //Seeding some games
    Game *g1 = [[Game alloc] init];
    g1.id = 0;
    g1.numPlayers = 5;
    g1.location = @"Wilson";
    NSString *str =@"12-4-2013 09:25 PM";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    NSDate *date = [formatter dateFromString:str];
    g1.time = date;
    
    Game *g2 = [[Game alloc] init];
    g2.id = 1;
    g2.numPlayers = 7;
    g2.location = @"Brodie";
    NSString *str2 =@"12-5-2013 07:17 PM";
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm a"];
    NSDate *date2 = [formatter dateFromString:str2];
    g2.time = date2;
    
    NSMutableArray *allGames = [NSMutableArray array];
    [allGames addObject:g1];
    [allGames addObject:g2];
    games = [NSArray arrayWithArray:allGames];

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
        return [games count];
        
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
        Game *g = [games objectAtIndex:indexPath.row];
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
        Game *main = [games objectAtIndex:indexPath.row];
        destViewController.location = main.location;
        destViewController.time = main.time;
        destViewController.numPlayers = main.numPlayers;
    }
}



@end
