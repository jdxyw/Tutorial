//
//  MoveMeController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelViewController.h"

@interface MoveMeController : SecondLevelViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *list;
}

@property (nonatomic,retain) NSMutableArray *list;


@end
