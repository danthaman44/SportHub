//
//  GameDetailViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "GameDetailViewController.h"

@interface GameDetailViewController ()
{
    NSInteger numPlayers;
    NSDate *time;
    NSString *location;
}
@end

@implementation GameDetailViewController
@synthesize timeLabel;
@synthesize locationLabel;
@synthesize numPlayersLabel;
@synthesize gameId;

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
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    timeLabel.text = newDateString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
