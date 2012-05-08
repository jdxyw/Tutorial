//
//  ListEditViewController.h
//  StoryboardSample2
//
//  Created by jdxyw on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListEditViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *editText;
@property (copy, nonatomic) NSDictionary *selection; 
@property (weak, nonatomic) id preViewController;

@end
