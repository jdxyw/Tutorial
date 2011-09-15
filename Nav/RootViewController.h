//
//  RootViewController.h
//  Nav
//
//  Created by jdxyw on 11-9-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController
<UITableViewDelegate,UITableViewDataSource> {
    NSArray *controllers;
}

@property (nonatomic,retain) NSArray *controllers;

@end
