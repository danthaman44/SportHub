//
//  SearchGameViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface SearchGameViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView  *mainTableView;
@property (strong, nonatomic) NSArray* games;
@property (strong, nonatomic) NSArray* privateGames;
@property (strong, nonatomic) NSArray* searchResults;
@property (strong, nonatomic) Game* selectedGame;

-(IBAction)privateGameSearch:(id)sender;
-(IBAction)resignFirst:(id)sender;

@end
