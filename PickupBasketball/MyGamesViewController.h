//
//  MyGamesViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 12/3/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGamesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView  *mainTableView;

@end
