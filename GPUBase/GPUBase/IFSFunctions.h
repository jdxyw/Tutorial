//
//  IFSFunctions.h
//  GPUBase
//
//  Created by jdxyw on 11-12-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIkit.h>

typedef struct{
    CGPoint p;
    float red;
    float green;
    float blue;
}DataPoint;

@interface IFSFunctions : NSObject
{
    NSMutableArray *parameter;
    NSMutableArray *color;
}

@property (nonatomic,retain) NSMutableArray *parameter;
@property (nonatomic,retain) NSMutableArray *color;

-(void)initParameter;

-(DataPoint)caculate:(DataPoint) point;
-(DataPoint)Sinusodial:(DataPoint) point;
-(DataPoint)Spherical:(DataPoint) point;
-(DataPoint)Swirl:(DataPoint)point;
-(DataPoint)FishEye:(DataPoint)point;
-(DataPoint)Handkerchief:(DataPoint)point;
-(DataPoint)HorseShoe:(DataPoint)point;
-(DataPoint)Polar:(DataPoint)point;
-(DataPoint)Heart:(DataPoint)point;
-(DataPoint)Disc:(DataPoint)point;
-(DataPoint)Diamond:(DataPoint)point;
-(DataPoint)Ex:(DataPoint)point;
-(UIColor *)colorfunction:(float)rand;

@end
