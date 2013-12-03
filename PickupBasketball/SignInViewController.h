//
//  SignInViewController.h
//  PickupBasketball
//
//  Created by Matthew Parides on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *uidField;
@property (weak, nonatomic) IBOutlet UITextField *passField;

-(IBAction)selectAndMove:(id)sender;
-(IBAction) resignFirst:(id)sender;
@end
