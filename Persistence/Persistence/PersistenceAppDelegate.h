//
//  PersistenceAppDelegate.h
//  Persistence
//
//  Created by jdxyw on 11-9-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersistenceViewController;

@interface PersistenceAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PersistenceViewController *viewController;

@end
