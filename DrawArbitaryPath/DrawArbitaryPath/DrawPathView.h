//
//  DrawPathView.h
//  DrawArbitaryPath
//
//  Created by jdxyw on 11-9-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawPathView : UIView
{
    //NSMutableArray *frompath;
    //NSMutableArray *topath;
    //BOOL isTouch;
    UIBezierPath *current;
    NSMutableArray *paths;
}

@property UIBezierPath *current;

@end
