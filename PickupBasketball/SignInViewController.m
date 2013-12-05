//
//  SignInViewController.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"
#import "CreateGameViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)selectAndMove:(id)sender {
    if([((UIButton*)sender).titleLabel.text isEqualToString:@"Sign Up"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        SignUpViewController *signup = (SignUpViewController*)[storyboard instantiateViewControllerWithIdentifier:@"signup"];
        [self presentViewController:signup animated:YES completion:nil];
    }
    else if([((UIButton*)sender).titleLabel.text isEqualToString:@"Enter"]){
        NSString *queryString = [NSString stringWithFormat:@"http://dukedb-spm23.cloudapp.net/django/db-beers/login_user"];
        NSMutableURLRequest *theRequest=[NSMutableURLRequest
                                         requestWithURL:[NSURL URLWithString:
                                                         queryString]
                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
        [theRequest setHTTPMethod:@"POST"];
        NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:self.uidField.text, @"Username",
                                  self.passField.text, @"Password", nil];
        
        NSError *error=nil;
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:postDict
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        //NSString* blah = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", blah);
        
        
        [theRequest setHTTPBody:jsonData];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        //NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        //NSLog(@"%@", returnString);
        if([returnString isEqualToString:@"True"]) {
            [LoggedInUser getInstance].username = self.uidField.text;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            UITabBarController *tabbar = (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
            ((CreateGameViewController*)[tabbar.viewControllers objectAtIndex:0]).userID = self.uidField.text;
            [self presentViewController:tabbar animated:YES completion:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User/Password pair doesn't exist!"
                                                            message:@"Your username or password don't match our records."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(IBAction) resignFirst:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LoggedInUser getInstance];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
