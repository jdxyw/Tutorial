//
//  Simple_TableViewController.h
//  Simple Table
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Simple_TableViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSArray *listdata;
}

@property (nonatomic,retain) NSArray *listdata;

@end
