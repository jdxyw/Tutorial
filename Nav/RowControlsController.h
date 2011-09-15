//
//  RowControlsController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

#define kSwitch 100

@interface RowControlsController : SecondLevelViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSArray *list;
}

@property (nonatomic,retain) NSArray *list;

@end
