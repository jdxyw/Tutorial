//
//  SwitchViewcontroller.h
//  View Switch
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueViewController;
@class YellowViewController;

@interface SwitchViewcontroller : UIViewController{
    YellowViewController *yellowcontroller;
    BlueViewController *bluecontroller;
}

@property (nonatomic,retain) YellowViewController *yellowcontroller;
@property (nonatomic,retain) BlueViewController *bluecontroller;

-(IBAction)switchViews:(id)sender;

@end
