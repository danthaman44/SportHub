//
//  SportPickerViewController.h
//  PickupBasketball
//
//  Created by Matthew Parides on 12/6/13.
//  Copyright (c) 2013 Wei Deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportPickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *sportPicker;
@property (strong, nonatomic) NSArray *sports;

-(IBAction)selectAndMove:(id)sender;

@end
