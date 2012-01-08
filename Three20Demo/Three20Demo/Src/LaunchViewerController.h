//
//  LaunchViewerController.h
//  Three20Demo
//
//  Created by jdxyw on 12-1-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@interface LaunchViewerController : TTViewController<TTLauncherViewDelegate>
{
    TTLauncherView *launchview;
}

@end
