//
//  UserSettingAppDelegate.h
//  UserSetting
//
//  Created by jdxyw on 11-9-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserSettingViewController;

@interface UserSettingAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UserSettingViewController *viewController;

@end
