//
//  LoggedInUser.m
//  PickupBasketball
//
//  Created by Matthew Parides on 12/4/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import "LoggedInUser.h"

@implementation LoggedInUser

static LoggedInUser *instance =nil;
+(LoggedInUser *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [LoggedInUser new];
        }
    }
    return instance;
}
@end