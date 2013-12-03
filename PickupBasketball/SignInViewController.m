//
//  SignInViewController.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "SignInViewController.h"
#import "SignUpViewController.h"

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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UITabBarController *tabbar = (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
        [self presentViewController:tabbar animated:YES completion:nil];
    }
}

-(IBAction) resignFirst:(id)sender {
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
