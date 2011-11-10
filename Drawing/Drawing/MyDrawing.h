//
//  MyDrawing.h
//  Drawing
//
//  Created by jdxyw on 11-9-27.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDrawing : UIView{
    CGPoint toPoint;
    CGPoint fromPoint;
    UIImage* background;
}

@property CGPoint toPoint;
@property CGPoint fromPoint;
@property UIImage* background;

@end
