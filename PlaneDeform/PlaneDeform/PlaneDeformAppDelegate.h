//
//  PlaneDeformAppDelegate.h
//  PlaneDeform
//
//  Created by jdxyw on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaneDeformViewController;

@interface PlaneDeformAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PlaneDeformViewController *viewController;

@end
