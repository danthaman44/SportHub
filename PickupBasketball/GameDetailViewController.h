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
@property (nonatomic, strong) NSString *gameId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *numPlayers;

@end
