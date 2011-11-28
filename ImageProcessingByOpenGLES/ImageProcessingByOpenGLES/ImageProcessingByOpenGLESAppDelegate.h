//
//  ImageProcessingByOpenGLESAppDelegate.h
//  ImageProcessingByOpenGLES
//
//  Created by jdxyw on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageProcessingByOpenGLESViewController;

@interface ImageProcessingByOpenGLESAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ImageProcessingByOpenGLESViewController *viewController;

@end
