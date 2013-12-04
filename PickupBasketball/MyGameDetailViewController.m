//
//  MyGameDetailViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "MyGameDetailViewController.h"

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
    timeLabel.text = time;
    locationLabel.text = location;
    numPlayersLabel.text = numPlayers;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
