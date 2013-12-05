//
//  MyGamesViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 12/3/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "MyGamesViewController.h"
#import "MyGameDetailViewController.h"
#import "Game.h"


@interface MyGamesViewController ()
{
    NSArray *locations;
    NSArray *games;
    NSArray *times;
    NSArray *Ids;
    NSArray *playerCounts;
}

@end

@implementation MyGamesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    locations = [NSArray arrayWithObjects:@"Wilson", @"Brodie",nil];
    times = [NSArray arrayWithObjects:@"5:00", @"6:00", nil];
    playerCounts = [NSArray arrayWithObjects:@"5", @"9", nil];
    
    //Seeding some games
    Game *g1 = [[Game alloc] init];
    g1.id = 0;
    g1.numPlayers = 5;
    g1.location = @"Wilson";
    NSString *str =@"12/4/2013 09:25 PM";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    NSDate *date = [formatter dateFromString:str];
    g1.time = date;
    
    Game *g2 = [[Game alloc] init];
    g2.id = 1;
    g2.numPlayers = 7;
    g2.location = @"Brodie";
    NSString *str2 =@"12/5/2013 07:17 PM";
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm a"];
    NSDate *date2 = [formatter dateFromString:str2];
    g2.time = date2;
    
    NSMutableArray *allGames = [NSMutableArray array];
    [allGames addObject:g1];
    [allGames addObject:g2];
    games = [NSArray arrayWithArray:allGames];
    
    
    NSDate *today = [NSDate date];
    NSDate *pickerDate = [today dateByAddingTimeInterval:10];
    
    //Just printing the time for debugging purposes.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    NSLog(@"User's current time in their preference format:%@",currentTime);
    
    
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];

    localNotification.fireDate = pickerDate;
    localNotification.alertBody = @"You have a game in hour";
    localNotification.alertAction = @"You have a game in hour";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyGameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Game *g = [games objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *time = [dateFormatter stringFromDate:g.time];
    NSString *location = g.location;
    NSString *cellValue = [NSString stringWithFormat: @"%@ %@ %@", time, @" - ", location];
    cell.textLabel.text = cellValue;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMyGameDetail"]) {
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        MyGameDetailViewController *destViewController = segue.destinationViewController;
        Game *main = [games objectAtIndex:indexPath.row];
        destViewController.location = main.location;
        destViewController.time = main.time;
        destViewController.numPlayers = main.numPlayers;
    }
}


@end
