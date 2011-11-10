//
//  CALayerAppDelegate.h
//  CALayer
//
//  Created by jdxyw on 11-11-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CALayerViewController;

@interface CALayerAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CALayerViewController *viewController;

@end
