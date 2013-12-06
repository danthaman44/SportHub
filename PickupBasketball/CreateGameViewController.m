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

//@synthesize datePicker;
//@synthesize createButton;
//@synthesize locationPicker;
//@synthesize locations;
//@synthesize togglePrivate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray* frisbeeFields = [[NSArray alloc] initWithObjects:@"East Main Quad", @"West Main Quad", @"Central Campus Field", @"Koskinen", nil];
    NSArray* basketballCourts = [[NSArray alloc] initWithObjects:@"Wilson", @"Brodie", @"Central Campus Courts", nil];
    NSDictionary *sportLocs = @{@"Frisbee" : frisbeeFields,
                                @"Soccer" : frisbeeFields,
                                @"Basketball" : basketballCourts};
    self.locations  = [sportLocs objectForKey:self.sport];
    self.datePicker.minimumDate = [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 0 ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)displayGameInfo:(id)sender {
	NSDate * selected = [self.datePicker date];
	NSString * date = [selected descriptionWithLocale:[NSLocale currentLocale]];
    date = [date substringToIndex:[date length]-22];
    NSLog(@"%@",date);
    
    NSInteger row = [self.locationPicker selectedRowInComponent:0];
    NSString * location = [self.locations objectAtIndex:row];
    NSLog(@"%@", location);
    
    NSString * sport = self.sport;
    
    NSString * private = self.togglePrivate.on ? @"True" : @"False";
    
    
    NSString *queryString = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/create_game"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:queryString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [theRequest setHTTPMethod:@"POST"];
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:[LoggedInUser getInstance].username, @"Username", date, @"Time", location, @"Location", sport, @"Sport", private, @"Private",  nil];
    NSError *error=nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&error];
    [theRequest setHTTPBody:jsonData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    //NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (returnData) {
        NSLog(@"success! %@", returnString);
    } else {
        
        //something bad happened
    }
}
@end
