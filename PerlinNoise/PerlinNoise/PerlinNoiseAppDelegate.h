//
//  PerlinNoiseAppDelegate.h
//  PerlinNoise
//
//  Created by jdxyw on 11-12-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PerlinNoiseViewController;

@interface PerlinNoiseAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PerlinNoiseViewController *viewController;

@end
