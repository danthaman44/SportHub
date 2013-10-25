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
@synthesize locationPicker;
@synthesize locations;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locations  = [[NSArray alloc] initWithObjects:@"Wilson Gym",@"Brodie Gym",@"Central Campus Courts", nil];
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
    
    NSInteger row = [locationPicker selectedRowInComponent:0];
    NSString * location = [locations objectAtIndex:row];
    NSLog(@"%@", location);
    

}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.locations objectAtIndex:row];
}

@end
