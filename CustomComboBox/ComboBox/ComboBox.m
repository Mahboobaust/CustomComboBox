

#import "ComboBox.h"
#import "ComboBoxCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComboBox

#define ARROW_WIDTH 23.0f

#define HEX_COLOR_BORDER @"#dd5216"
#define HEX_COLOR_SIDE_LABEL_BACKGROUND @"#ef9999"
#define HEX_COLOR_HEAD_LABEL_BACKGROUND @"#ef9660"
#define HEX_COLOR_TOP_LABEL_BACKGROUND @"#9d6660"


- (id)initWithFrame:(CGRect)frame ArrowWidth:(int)arrowWidth ArrowHeight:(int)arrowHeight ArrowImage:(UIImage*)arrowImage ArrowOffset:(int)arrowOffset
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"ComboBox" owner:self options:nil];
        [self addSubview:self.view];
        [self.view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_button setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_label setFrame:CGRectMake(2, 0,frame.size.width- arrowWidth-arrowOffset-4, frame.size.height)];
        [_arrow setFrame:CGRectMake(frame.size.width-arrowWidth-arrowOffset, 2, arrowWidth, arrowHeight)];
        [_arrow setCenter:CGPointMake(_arrow.center.x, frame.size.height/2)];
        [_arrow setImage:arrowImage];
        
       
        
        
        defaultComboBoxTableSize = CGSizeMake(self.view.frame.size.width, 100);
       
        _comboBoxTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, _button.frame.origin.y+_button.frame.size.height, self.view.frame.size.width, 0)];
       // _comboBoxTableView.layer.borderWidth = 1.0;
        //_comboBoxTableView.layer.borderColor = [[UIColor blackColor] CGColor];
        
        _comboBoxTableView.delegate = self;
        _comboBoxTableView.dataSource = self;
        
        [self.view addSubview:_comboBoxTableView];
        
        //_button.layer.borderWidth = 1.0;
        //_button.layer.borderColor = [[UIColor blueColor] CGColor];
        
        _button.layer.borderColor=[ [self colorFromHexString:HEX_COLOR_BORDER]CGColor];
       // _button.layer.borderWidth= 1.4f;
        //_button.layer.cornerRadius=5.0;
        
        self.view.layer.borderColor=[ [self colorFromHexString:HEX_COLOR_BORDER]CGColor];
       // self.view.layer.borderWidth= 1.4f;
      //  self.view.layer.cornerRadius=5.0;

        
        _comboBoxTableView.bounces=NO;
        [_comboBoxTableView setShowsHorizontalScrollIndicator:NO];
        [_comboBoxTableView setShowsVerticalScrollIndicator:NO];
        
        [_comboBoxTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
  
    [self setControlsDefaultProperties];
    
    [self createFadeView];
}

-(void)setControlsDefaultProperties{
    
    _comboboxButtonFont=_comboboxButtonFont?:[UIFont fontWithName:@"HelveticaNeue" size:8];
    _comboboxButtonFontColorNormal=_comboboxButtonFontColorNormal?:[UIColor blackColor];
     _comboboxButtonBGColorNormal=_comboboxButtonBGColorNormal?:[UIColor whiteColor];
    
     _comboboxButtonFontColorSelected=_comboboxButtonFontColorSelected?:_comboboxButtonFontColorNormal;
     _comboboxButtonBGColorSelected=_comboboxButtonBGColorSelected?:_comboboxButtonBGColorNormal;
    
    
    _comboboxDropDownFont=_comboboxDropDownFont?:_comboboxButtonFont;
    _comboboxDropDownFontColor=_comboboxDropDownFontColor?:_comboboxButtonFontColorNormal;
    _comboboxDropDownBGColor=_comboboxDropDownBGColor?:_comboboxButtonBGColorNormal;
    
    
    [_label setFont:_comboboxButtonFont];
    [_label setTextColor:_comboboxButtonFontColorNormal];
    [_label setBackgroundColor:_comboboxButtonBGColorNormal];
    
    [self.view setBackgroundColor:_comboboxButtonBGColorNormal];
    
    _comboboxButtonMinimumAdjustedFontSize=_comboboxButtonMinimumAdjustedFontSize!=0?:8;
    _label.numberOfLines = 1;
    _label.minimumScaleFactor = _comboboxButtonMinimumAdjustedFontSize/_label.font.pointSize;
    _label.adjustsFontSizeToFitWidth = YES;

}

-(void)createFadeView{
    UIView *superTopView,*superView;
    
    if([self.delegate isKindOfClass:[UIView class]]){
        superTopView=(UIView*)self.delegate;
    }
    else if([self.delegate isKindOfClass:[UIViewController class]]){
        superTopView=((UIViewController*)self.delegate).view;
    }
    
    superView=self.superview;
    
    int offsetX=0,offsetY=0;
    offsetX=-(1)*superView.frame.origin.x;
    offsetY=-(1)*superView.frame.origin.y;

    fadeMainView=[[UIView alloc]initWithFrame:CGRectMake(offsetX, offsetY, 768, 1024)];
    [superView addSubview:fadeMainView];
    [fadeMainView setHidden:YES];
    
    UIImageView *fadeSubView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, fadeMainView.frame.size.width, fadeMainView.frame.size.height)];
    [fadeSubView setBackgroundColor:[UIColor blackColor]];
    [fadeSubView setAlpha:0.2];
    [fadeMainView addSubview:fadeSubView];
   // [fadeSubView setHidden:YES];
    
    //fadeMainView.layer.zPosition=superTopView.layer.zPosition;
    fadeMainView.layer.zPosition=0.0;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideTouched)];
    singleTap.numberOfTapsRequired = 1;
    [fadeSubView setUserInteractionEnabled:YES];
    [fadeSubView addGestureRecognizer:singleTap];
}



-(void)outsideTouched{
   
    [self showFadeView:NO];
    
    [self closeComboBoxWithAnimation:_comboBoxTableView OutsideTouched:YES];
     //[self.delegate comboBox:self didCloseNoAction:YES];
}

-(void)showFadeView:(BOOL)show{
    
    [fadeMainView setHidden:!show];
}


-(void)openComboBoxWithAnimation:(UITableView *)comboBoxTableView {
  
    if(_allowSelectionPropertiesChange){
        //[self changeControlsPropertiesForSelected:NO];
    }
    
    transView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, _button.frame.origin.y+_button.frame.size.height, self.frame.size.width, 2)];
    [transView setBackgroundColor:[UIColor blackColor]];
    [transView setAlpha:0.07];
    [self.view addSubview:transView];
    int viewOffset= (defaultComboBoxTableSize.width-self.frame.size.width)/2;
    viewOffset-=_viewOffset;
    
    [self showFadeView:YES];
    
    [self.superview bringSubviewToFront:self];
    
     if([self.delegate respondsToSelector:@selector(comboBox:didStartedOpening:)])
         [self.delegate comboBox:self didStartedOpening:YES];
    
    [UIView animateWithDuration:0.25
                     animations:^(void){
                         [_comboBoxTableView setFrame:CGRectMake(self.view.frame.origin.x-viewOffset, _button.frame.origin.y+_button.frame.size.height+transView.frame.size.height, defaultComboBoxTableSize.width, defaultComboBoxTableSize.height)];
                         CGRect frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                         frame = self.view.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                         if([self.delegate respondsToSelector:@selector(comboBox:didOpen:)])
                             [self.delegate comboBox:self didOpen:YES];
                     }];
   }

-(void)closeComboBoxWithAnimation:(UITableView *)comboBoxTableView OutsideTouched:(BOOL)outsideTouched{
   
    
    [transView removeFromSuperview];
    
     if([self.delegate respondsToSelector:@selector(comboBox:didStartedOpening:)])
         [self.delegate comboBox:self didStartedOpening:NO];
    
    [UIView animateWithDuration:0.25
                     animations:^(void){
                         [_comboBoxTableView setFrame:CGRectMake(self.view.frame.origin.x, _button.frame.origin.y+_button.frame.size.height, self.frame.size.width, 0)];
                         CGRect frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                         frame = self.view.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.view.frame = frame;
                     }
                     completion:^(BOOL finished){
                         [self.superview sendSubviewToBack:self];
                         [self showFadeView:NO];
                         if([self.delegate respondsToSelector:@selector(comboBox:didOpen:)])
                             [self.delegate comboBox:self didOpen:NO];
                     }];

    
    //[self changeControlsPropertiesForSelected:!outsideTouched];
    
    if (_Selected) {
        //[self.delegate comboBox:self didCloseNoAction:NO];

    }
    else
    {
        //[self.delegate comboBox:self didCloseNoAction:YES];
    }
    
   }

-(void)changeControlsPropertiesForSelected:(BOOL)selected{
   
    if(selected){
        if(_allowSelectionPropertiesChange){
            [_label setBackgroundColor:_comboboxButtonBGColorSelected];
            [_label setTextColor:_comboboxButtonFontColorSelected];
            
            [self.view setBackgroundColor:_comboboxButtonBGColorSelected];
        }
    }
    else{
        [_label setBackgroundColor:_comboboxButtonBGColorNormal];
        [_label setTextColor:_comboboxButtonFontColorNormal];
        
        [self.view setBackgroundColor:_comboboxButtonBGColorNormal];
    }
}

-(void)setComboBoxSize:(CGSize)size{
    
    defaultComboBoxTableSize = size;
}


-(void)setComboBoxData:(NSArray *)comboBoxData{
    _comboBoxDataArray = [NSArray arrayWithArray:comboBoxData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comboBoxDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ComboCell";
    ComboBoxCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ComboBoxCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    [cell.titleLabel setFont:_comboboxDropDownFont];
    [cell.titleLabel setTextColor:_comboboxDropDownFontColor];
    [cell.imageView setBackgroundColor:_comboboxDropDownBGColor];
    
    CGRect frame = cell.frame;
    frame.size.width = defaultComboBoxTableSize.width;
    frame.size.height = _rowHeight;
    cell.frame = frame;
   
    if(indexPath.row==_comboBoxDataArray.count-1){
        [cell.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    else{
        [cell.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-1)];
        UIView *separator=[[UIView alloc]initWithFrame:CGRectMake(1, frame.size.height-1, frame.size.width-2*1, 0.5)];
        [separator setBackgroundColor:UIColorFromRGB(0xc9c9c9)];
        [separator setAlpha:0.7];
        [cell addSubview:separator];
    }
    
    cell.titleLabel.text = [_comboBoxDataArray objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    _label.text=[_comboBoxDataArray objectAtIndex:indexPath.row];
    [self closeComboBoxWithAnimation:_comboBoxTableView OutsideTouched:NO];
    
     if([self.delegate respondsToSelector:@selector(comboBox:didSelectRowAtIndexPath:)])
         [self.delegate comboBox:self didSelectRowAtIndexPath:indexPath];
   
}


- (IBAction)openComboBox:(UIButton *)sender {
    
    if (_comboBoxTableView.frame.size.height == 0) {
        [_comboBoxTableView reloadData];
        [self openComboBoxWithAnimation:_comboBoxTableView];
    }
    else {
        [self closeComboBoxWithAnimation:_comboBoxTableView OutsideTouched:YES];
    }
    
}

-(void)setComboBoxTitle:(NSString *)title{
    _label.text=title;
   
}


-(UIColor *) colorFromHexString:(NSString *)hexString {
    
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
