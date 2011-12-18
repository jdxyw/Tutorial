//
//  IFSFunctions.h
//  GPUBase
//
//  Created by jdxyw on 11-12-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface IFSFunctions : NSObject
{
    NSMutableArray *parameter;
}

@property (nonatomic,retain) NSMutableArray *parameter;

-(void)initParameter;

-(CGPoint)caculate:(CGPoint) point;
+(CGPoint)Sinusodial:(CGPoint) point;
+(CGPoint)Spherical:(CGPoint) point;
+(CGPoint)Swirl:(CGPoint)point;
+(CGPoint)FishEye:(CGPoint)point;
+(CGPoint)Handkerchief:(CGPoint)point;

@end
