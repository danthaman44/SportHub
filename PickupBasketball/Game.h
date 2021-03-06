//
//  Game.h
//  PickupBasketball
//
//  Created by Wei Deng on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *sport;
@property (strong, nonatomic) NSDate *time;
@property (assign, nonatomic) NSInteger gid;
@property (assign, nonatomic) NSInteger numPlayers;
@property (strong, nonatomic) NSString* isPrivate;
@property (strong, nonatomic) NSArray *players;
@end
