//
//  CustomComboBoxViewController.m
//  CustomComboBox
//
//  Created by Mahboob on 8/26/15.
//  Copyright (c) 2015 Mahboob. All rights reserved.
//

#import "CustomComboBoxViewController.h"

@interface CustomComboBoxViewController ()

@end

@implementation CustomComboBoxViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    daysArray=[[NSArray alloc]initWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
     dayImageArray=[[NSArray alloc]initWithObjects:@"sunday.png",@"monday.jpeg",@"tuesday.jpeg",@"wednesday.jpeg",@"thursday.png",@"friday.jpeg",@"saturday.jpeg", nil];
    [self createComboBox];
    _displayLabel.layer.cornerRadius=3.0;
    _displayLabel.backgroundColor=UIColorFromRGB(0xf5f5f5);
    _displayLabel.layer.borderWidth=3.0;
    _displayLabel.layer.borderColor=[[UIColor orangeColor]CGColor];
    _displayLabel.text=@"No day selected";
    if (IDIOM==IPAD) {
        _displayLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:40.0];
    }
    else
    {
        _displayLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18.0];
    }
    // Do any additional setup after loading the view from its nib.
}

-(void)createComboBox
{
      int  xPOS=50,yPOS=50,height=50,width=150;
    if (IDIOM==IPAD) {
       // _displayLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:40.0];
    }
    else
    {
         xPOS=20,yPOS=50,height=40,width=120;
    }

    cbxDays = [[ComboBox alloc]initWithFrame:CGRectMake(xPOS, yPOS, width, height) ArrowWidth:20 ArrowHeight:20 ArrowImage:[UIImage imageNamed:@"dropdownarrow"] ArrowOffset:10];
    cbxDays.delegate = self;
    [cbxDays setComboBoxSize:CGSizeMake(200, 43*[daysArray count])];
    [cbxDays setRowHeight:43];
    [cbxDays setAllowSelectionPropertiesChange:YES]; // Set Yes, If want to Change Color
    [cbxDays setComboboxButtonBGColorNormal:UIColorFromRGB(0xf8f8f8)];
    [cbxDays setComboboxButtonFontColorNormal:UIColorFromRGB(0x858585)];
    [cbxDays setComboboxButtonFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
    [cbxDays setComboboxButtonBGColorSelected:UIColorFromRGB(0xc3cf81)];
    [cbxDays setComboboxButtonFontColorSelected:UIColorFromRGB(0xffffff)];
    [cbxDays setComboboxButtonMinimumAdjustedFontSize:10];
    [cbxDays setComboBoxDataArray:daysArray];
    [cbxDays.label setText:@"Select a day"];
    [self.view addSubview:cbxDays];

}

-(void)comboBox:(ComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [cbxDays changeControlsPropertiesForSelected:YES];
    _displayLabel.text=comboBox.label.text;
    _dayImageView.image=[UIImage imageNamed:[dayImageArray objectAtIndex:indexPath.row]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
