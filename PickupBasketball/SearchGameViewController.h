//
//  SearchGameViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchGameViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView  *mainTableView;
@property (weak, nonatomic) IBOutlet UITextField *privateSearch;
@property (strong, nonatomic) NSMutableArray* games;
@property (strong, nonatomic) NSMutableArray* privateGames;
@property (strong, nonatomic) NSArray* searchResults;

@end
