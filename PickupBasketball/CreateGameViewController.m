//
//  FirstViewController.m
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "CreateGameViewController.h"

@interface CreateGameViewController ()

@end

@implementation CreateGameViewController

@synthesize datePicker;
@synthesize createButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)displayGameInfo:(id)sender {
	NSDate * selected = [datePicker date];
	NSString * date = [selected description];
    NSLog(@"%@",date);
    

}

@end
