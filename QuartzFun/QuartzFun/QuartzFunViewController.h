//
//  QuartzFunViewController.h
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuartzFunViewController : UIViewController{
    IBOutlet UISegmentedControl *colorcontroller;
}

@property (nonatomic,retain) IBOutlet UISegmentedControl *colorcontroller;
-(IBAction)changeColor:(id)sender;
-(IBAction)changeShape:(id)sender;

@end
