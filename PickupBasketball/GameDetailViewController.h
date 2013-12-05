//
//  GameDetailViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 12/2/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *numPlayersLabel;
@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, assign) NSInteger numPlayers;
@property (strong, nonatomic) IBOutlet UIButton *joinButton;

-(IBAction)joinGame;

@end
