
#import <UIKit/UIKit.h>
#import "Define.h"
@class ComboBox;

@protocol ComBoxDelegate <NSObject>

@optional

-(void)comboBox:(ComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)comboBox:(ComboBox *)comboBox didOpen:(BOOL)open;
-(void)comboBox:(ComboBox *)comboBox didStartedOpening:(BOOL)opening;
-(void)comboBox:(ComboBox *)comboBox didCloseNoAction:(BOOL)noAction;



@end

@interface ComboBox : UIView <UITableViewDataSource, UITableViewDelegate>
{
CGSize defaultComboBoxTableSize;
CGRect comboBoxTableViewFrame;
    
    UIImageView *transView;
    UIView *fadeMainView;
}
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *arrow;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) UITableView *comboBoxTableView;
@property (strong, nonatomic) NSArray *comboBoxDataArray;
@property int rowHeight;
@property BOOL allowSelectionPropertiesChange,Selected;


@property (strong, nonatomic) UIColor *comboboxButtonBGColorNormal;
@property (strong, nonatomic) UIColor *comboboxButtonBGColorSelected;
@property (strong, nonatomic) UIFont *comboboxButtonFont;
@property (strong, nonatomic) UIColor *comboboxButtonFontColorNormal;
@property (strong, nonatomic) UIColor *comboboxButtonFontColorSelected;

@property (strong, nonatomic) UIColor *comboboxDropDownBGColor;
@property (strong, nonatomic) UIFont *comboboxDropDownFont;
@property (strong, nonatomic) UIColor *comboboxDropDownFontColor;
@property int viewOffset;

@property int comboboxButtonMinimumAdjustedFontSize;

@property (strong, nonatomic) id <ComBoxDelegate> delegate;

- (id)initWithFrame:(CGRect)frame ArrowWidth:(int)arrowWidth ArrowHeight:(int)arrowHeight ArrowImage:(UIImage*)arrowImage ArrowOffset:(int)arrowOffset;

-(void)setComboBoxData:(NSArray *)comboBoxData;

-(void)setComboBoxSize:(CGSize)size;
- (IBAction)openComboBox:(UIButton *)sender;

-(void)setComboBoxTitle:(NSString *)title;
-(void)changeControlsPropertiesForSelected:(BOOL)selected;

@end
