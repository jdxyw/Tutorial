//
//  UserSettingViewController.h
//  UserSetting
//
//  Created by jdxyw on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSettingViewController : UIViewController
{
    IBOutlet UISegmentedControl *segmentController;
    IBOutlet UITextField *field;
    IBOutlet UISlider *slider;
}

@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentController; 
@property (nonatomic,retain) IBOutlet UITextField *field;
@property (nonatomic,retain) IBOutlet IBOutlet UISlider *slider;;

-(IBAction)textFieldFinishEditing:(id)sender;
-(IBAction)sliderValueChange:(id)sender;
-(IBAction)segmentChange:(id)sender;

@end
