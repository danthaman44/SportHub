//
//  SignUpViewController.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)selectAndMove:(id)sender {
        if([((UIButton*)sender).titleLabel.text isEqualToString:@"Enter"]){
            if([self.passField.text isEqualToString:self.passVerifyField.text]) {
                NSString *queryString = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/create_user"];
                NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                                 requestWithURL:[NSURL URLWithString:
                                                                 queryString]
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                 timeoutInterval:60.0];
                [theRequest setHTTPMethod:@"POST"];
                NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:self.uidField.text, @"Username",
                                            self.passField.text, @"Password", self.emailField.text, @"Email", self.phnumField.text, @"Phone", nil];
                
                NSError *error=nil;
                
                NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                                   options:NSJSONWritingPrettyPrinted error:&error];
                NSString* blah = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSLog(@"%@", blah);
                
                
                [theRequest setHTTPBody:jsonData];
                NSData *returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
                NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
                NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                NSLog(@"%@", returnString);
                if (con && [returnString isEqualToString:@"True"]) {
                    
                    NSLog(@"success! %@", returnString);
                } else { 
                    //something bad happened
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
}

-(IBAction)resignFirst:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
