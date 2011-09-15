//
//  SingleComponentPickerViewController.h
//  Picker
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleComponentPickerViewController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UIPickerView *pickview;
    NSArray *pickdata;
}

@property (nonatomic,retain) IBOutlet UIPickerView *pickview;
@property (nonatomic,retain) NSArray *pickdata;

-(IBAction)buttonPressed;

@end
