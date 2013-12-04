//
//  MyGamesViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 12/3/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "MyGamesViewController.h"
#import "MyGameDetailViewController.h"


@interface MyGamesViewController ()
{
    NSArray *locations;
    NSArray *times;
    NSArray *Ids;
    NSArray *playerCounts;
    NSInteger myIntegers[10];
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
    
    for (NSInteger i = 0; i < 2; i++) {
        myIntegers[i] = i;
    }
    
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
    return [locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyGameCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *time = [times objectAtIndex:indexPath.row];
    NSString *location = [locations objectAtIndex:indexPath.row];
    
    NSString *cellValue = [NSString stringWithFormat: @"%@ %@ %@", time, @" - ", location];
    
    cell.textLabel.text = cellValue;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMyGameDetail"]) {
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        MyGameDetailViewController *destViewController = segue.destinationViewController;
        destViewController.location = [locations objectAtIndex:indexPath.row];
        destViewController.time = [times objectAtIndex:indexPath.row];
        destViewController.numPlayers = [playerCounts objectAtIndex:indexPath.row];
    }
}


@end
