//
//  MyGameDetailViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "MyGameDetailViewController.h"
#import "LoggedInUser.h"

@interface MyGameDetailViewController ()

@end

@implementation MyGameDetailViewController
@synthesize timeLabel;
@synthesize time;
@synthesize locationLabel;
@synthesize numPlayersLabel;
@synthesize gameId;
@synthesize location;
@synthesize numPlayers;

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
    //Show the game time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *timeForLabel = [dateFormatter stringFromDate:time];
    self.timeLabel.text = timeForLabel;
    
    //Show game location
    self.locationLabel.text = location;
    
    //Show number of players
    self.numPlayersLabel.text = [NSString stringWithFormat:@"%d", numPlayers];;
    self.GIDLabel.text = [NSString stringWithFormat:@"%d", self.gameId];
    self.sportLabel.text = self.sport;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)leaveGame {
    NSString *userName = [LoggedInUser getInstance].username;
    NSString *queryString = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/leave_game"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                     requestWithURL:[NSURL URLWithString:
                                                     queryString]
                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                     timeoutInterval:60.0];
    [theRequest setHTTPMethod:@"POST"];
    
    NSString *IdAsString = [NSString stringWithFormat:@"%d", gameId];
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys: userName, @"Username", IdAsString, @"GameId", nil];

    
    NSError *error=nil;
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    
    [theRequest setHTTPBody:jsonData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    if ([returnString isEqualToString:@"True"]) {
        NSLog(@"success!");
    } else {
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
