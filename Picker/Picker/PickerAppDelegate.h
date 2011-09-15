//
//  PickerAppDelegate.h
//  Picker
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerAppDelegate : NSObject <UIApplicationDelegate>
{
    IBOutlet UITabBarController *rootcontroller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootcontroller;

@end
