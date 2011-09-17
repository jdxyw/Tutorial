//
//  QuartzFunView.h
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"

@interface QuartzFunView : UIView{
    CGPoint firsttouch;
    CGPoint lasttouch;
    UIColor *currentcolor;
    ShapeType shapetype;
    UIImage *drawimage;
    BOOL useRandomColor;
}

@property CGPoint firsttouch;
@property CGPoint lasttouch;
@property (nonatomic,retain) UIColor *currentcolor;
@property ShapeType shapetype;
@property (nonatomic,retain) UIImage *drawimage;
@property BOOL useRandomColor;

@end
