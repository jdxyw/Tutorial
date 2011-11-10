//
//  AddSubViewWithAnimationViewController.h
//  AddSubViewWithAnimation
//
//  Created by jdxyw on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSubViewWithAnimationViewController : UIViewController
{
    IBOutlet UIButton *btn;
    BOOL popup;
}

@property (nonatomic,retain) IBOutlet UIButton *btn;

-(IBAction)btnClick:(id)sender;

@end
