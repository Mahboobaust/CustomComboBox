//
//  CustomComboBoxViewController.h
//  CustomComboBox
//
//  Created by Mahboob on 8/26/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.

//

#import <UIKit/UIKit.h>
#import "ComboBox.h"
@interface CustomComboBoxViewController : UIViewController<ComBoxDelegate>
{
    ComboBox *cbxDays;
    NSArray *daysArray,*dayImageArray;
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dayImageView;

@end
