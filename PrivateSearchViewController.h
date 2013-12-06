//
//  PrivateSearchViewController.h
//  PickupBasketball
//
//  Created by Matthew Parides on 12/6/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *privateSearch;
@property (strong, nonatomic) NSArray* privateGames;

-(IBAction)privateGameSearch:(id)sender;
-(IBAction)resignFirst:(id)sender;

@end
