//
//  Button_FunViewController.h
//  Button Fun
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Button_FunViewController : UIViewController{
    IBOutlet UILabel *statusText;
}

@property (nonatomic,retain) IBOutlet UILabel *statusText;

-(IBAction)buttonPressed:(id)sender;

@end
