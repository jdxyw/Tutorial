//
//  CircularScrollViewAppDelegate.h
//  CircularScrollView
//
//  Created by jdxyw on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircularScrollViewViewController;

@interface CircularScrollViewAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CircularScrollViewViewController *viewController;

@end
