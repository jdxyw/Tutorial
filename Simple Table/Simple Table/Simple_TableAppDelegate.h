//
//  Simple_TableAppDelegate.h
//  Simple Table
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Simple_TableViewController;

@interface Simple_TableAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Simple_TableViewController *viewController;

@end
