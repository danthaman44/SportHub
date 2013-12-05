//
//  LoggedInUser.h
//  PickupBasketball
//
//  Created by Matthew Parides on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggedInUser: NSObject {
}
@property(nonatomic,retain)NSString *username;
+(LoggedInUser*)getInstance;
@end
