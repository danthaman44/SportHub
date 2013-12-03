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
@synthesize togglePrivate;

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

- (void)sendJSON:(NSString*) arg1 withArg2: (NSString*) arg2 {
    NSString* jsonData = @"{\"Query\" : \"Test Data\"}";
    NSData* requestData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create URL to POST jsonData to.
    NSString* urlString = @"http://dukedb-spm23.cloudapp.net/django/db-beers/create_game";
    NSURL* url = [NSURL URLWithString:urlString];
    
    // Create request.
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: requestData];
    
    // Send request synchronously.
    NSURLResponse* response = [[NSURLResponse alloc] init];
    NSError* error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *responseBody = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"Response: ");
    NSLog(responseBody);
    
    // Check result.
    if (error != nil)
    {
        NSLog(@"submitted request!");
    }
    else {
        NSString* errorLogFormat = @"request failed, error: %@";
        NSLog(errorLogFormat, error);
    }
    
}

-(IBAction)displayGameInfo:(id)sender {
	NSDate * selected = [datePicker date];
	NSString * date = [selected description];
    NSLog(@"%@",date);
    
    NSInteger row = [locationPicker selectedRowInComponent:0];
    NSString * location = [locations objectAtIndex:row];
    NSLog(@"%@", location);
    
    [self sendJSON:date withArg2:location ];
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
