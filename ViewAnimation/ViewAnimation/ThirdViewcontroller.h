//
//  ThirdViewcontroller.h
//  ViewAnimation
//
//  Created by jdxyw on 11-10-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewcontroller : UIViewController
{
    IBOutlet UIView *myview;
    BOOL change;
    //UITextField *filed;
}

@property (nonatomic,retain)UIView *myview;
//@property (nonatomic,retain)IBOutleT UITextField* field;

-(IBAction)touchView:(id)sender;

@end
