//
//  SportPickerViewController.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/6/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SportPickerViewController.h"
#import "CreateGameViewController.h"

@interface SportPickerViewController ()

@end

@implementation SportPickerViewController

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
    _sports = [[NSArray alloc] initWithObjects:@"Frisbee", @"Soccer", @"Basketball", nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.sports count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [self.sports objectAtIndex:row];
}

-(IBAction)selectAndMove:(id)sender{
    [self performSegueWithIdentifier:@"CreateSeg" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CreateGameViewController* next = segue.destinationViewController;
    int row = [self.sportPicker selectedRowInComponent:0];
    next.sport = [self.sports objectAtIndex:row];
}


@end
