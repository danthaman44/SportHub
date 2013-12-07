//
//  MyGameDetailViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGameDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *numPlayersLabel;
@property (nonatomic, strong) IBOutlet UILabel *sportLabel;
@property (weak, nonatomic) IBOutlet UILabel *GIDLabel;
@property (nonatomic, assign) NSInteger gameId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *time;
@property (assign, nonatomic) NSInteger numPlayers;
@property (nonatomic, strong) NSString *sport;

-(IBAction)leaveGame;

@end
