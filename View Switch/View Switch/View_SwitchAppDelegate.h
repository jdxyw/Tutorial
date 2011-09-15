//
//  View_SwitchAppDelegate.h
//  View Switch
//
//  Created by jdxyw on 11-9-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchViewcontroller.h"

@interface View_SwitchAppDelegate : NSObject <UIApplicationDelegate>
{
    IBOutlet UIWindow *window;
    IBOutlet SwitchViewcontroller *switchviewcontroller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SwitchViewcontroller *switchviewcontroller;

@end
