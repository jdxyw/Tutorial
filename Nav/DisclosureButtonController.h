//
//  DisclosureButtonController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@class DisclosureDetailController;

@interface DisclosureButtonController : SecondLevelViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSArray *list;
    DisclosureDetailController *childcontroller;
}

@property (nonatomic,retain) NSArray *list;

@end
