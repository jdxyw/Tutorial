//
//  OpenGLESDrawingAppDelegate.h
//  OpenGLESDrawing
//
//  Created by jdxyw on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpenGLESDrawingViewController;

@interface OpenGLESDrawingAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet OpenGLESDrawingViewController *viewController;

@end
