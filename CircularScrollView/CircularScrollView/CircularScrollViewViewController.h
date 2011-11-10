//
//  CircularScrollViewViewController.h
//  CircularScrollView
//
//  Created by jdxyw on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularScrollViewViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scroll;
    NSMutableArray *documentTitles;
    
    int currIndex,nextIndex,prevIndex;
    
    UILabel* pageOneDoc;
    UILabel* pageTwoDoc;
    UILabel* pageThreeDoc;
}

@property (nonatomic,retain) IBOutlet UIScrollView *scroll;

- (void)loadPageWithId:(int)index onPage:(int)page;

@end
