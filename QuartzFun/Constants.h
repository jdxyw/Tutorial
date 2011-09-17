//
//  Constants.h
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#ifndef QuartzFun_Constants_h
#define QuartzFun_Constants_h

typedef enum {
    kLineShape=0,
    kRectShape,
    kEllipseShape,
    kImageShape
}ShapeType;

typedef enum {
    kRedColorTab=0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
}ColorTabIndex;

#define degreeToRadian(x) (3.1415926535897 * (x)/180)

#endif
