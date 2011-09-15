//
//  CellsViewController.h
//  Cells
//
//  Created by jdxyw on 11-9-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KNameValueTag 1
#define KColorValueTag 2

@interface CellsViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>{
    NSArray *computers;
}

@property (nonatomic,retain) NSArray *computers;

@end
