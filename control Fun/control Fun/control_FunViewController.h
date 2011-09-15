//
//  control_FunViewController.h
//  control Fun
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kShowSegmentIndex 0

@interface control_FunViewController : UIViewController <UIActionSheetDelegate>{
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *passField;
    IBOutlet UILabel *silderLabel;
    IBOutlet UISwitch *leftswitch;
    IBOutlet UISwitch *rightswitch;
    IBOutlet UIView *switchView;
    IBOutlet UIButton *doSomethingButton;
}

@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextField *passField;
@property (nonatomic,retain) IBOutlet UILabel *silderLabel;
@property (nonatomic,retain) IBOutlet UISwitch *leftswitch;
@property (nonatomic,retain) IBOutlet UISwitch *rightswitch;
@property (nonatomic,retain) IBOutlet UIView *switchview;
@property (nonatomic,retain) IBOutlet UIButton *doSomethingButton;

-(IBAction)textFielDoneEditing:(id)sender;
-(IBAction)backgroundClcik:(id)sender;
-(IBAction)sliderChange:(id)sender;
-(IBAction)switchChanged:(id)sender;
-(IBAction)toggleShowHide:(id)sender;
-(IBAction)dosomething:(id)sender;

@end
