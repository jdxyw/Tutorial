//
//  RandomTrianglesAppDelegate.h
//  RandomTriangles
//
//  Created by jdxyw on 11-12-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RandomTrianglesViewController;

@interface RandomTrianglesAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RandomTrianglesViewController *viewController;

@end
