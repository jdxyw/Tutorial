//
//  DrawingAppDelegate.h
//  Drawing
//
//  Created by jdxyw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawingViewController;

@interface DrawingAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DrawingViewController *viewController;

@end
