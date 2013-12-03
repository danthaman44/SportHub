//
//  FirstViewController.h
//  PickupBasketball
//
//  Created by Wei Deng on 10/24/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateGameViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate> {
    UIDatePicker *datePicker;
    UIButton *createButton;
    UIPickerView *locationPicker;
    UISwitch *togglePrivate;
    NSArray *locations;
}
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (strong, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) IBOutlet UISwitch *togglePrivate;

-(IBAction)displayGameInfo:(id)sender;

@end
