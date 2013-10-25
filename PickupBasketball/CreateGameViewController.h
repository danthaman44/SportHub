//
//  FirstViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateGameViewController : UIViewController {
    UIDatePicker *datePicker;
    UIButton *createButton;
    
}
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIButton *createButton;

-(IBAction)displayGameInfo:(id)sender;

@end
