//
//  CheckListController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@interface CheckListController : SecondLevelViewController
<UITableViewDataSource,UITableViewDelegate> {
    NSArray *list;
    NSIndexPath *lastIndexPath;
}

@property (nonatomic,retain) NSArray *list;
@property (nonatomic,retain) NSIndexPath *lastIndexPath;

@end
