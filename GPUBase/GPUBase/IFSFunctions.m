//
//  IFSFunctions.m
//  GPUBase
//
//  Created by jdxyw on 11-12-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "IFSFunctions.h"

#define ARC4RANDOM_MAX      0x100000000

@implementation IFSFunctions

@synthesize parameter;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        parameter=[[NSMutableArray alloc] init];
        for (int i=0; i<30; i++) {
            [parameter addObject:[NSNumber numberWithFloat:arc4random()*2.0/ARC4RANDOM_MAX-1.0]];
        }
    }
    
    return self;
}

+(CGPoint) Sinusodial:(CGPoint)point{
    return CGPointMake(sinf(point.x), sinf(point.y));
}

+(CGPoint) Spherical:(CGPoint)point{
    float r=point.x*point.x+point.y*point.y;
    return CGPointMake(point.x/r, point.y/r);
}

+(CGPoint) Swirl:(CGPoint)point{
    float r=point.x*point.x+point.y*point.y;
    return CGPointMake(point.x*sinf(r)-point.y*cosf(r), 
                       point.x*cosf(r)+point.y*sinf(r));
}

+(CGPoint) FishEye:(CGPoint)point{
    float r=sqrtf(point.x*point.x+point.y*point.y);
    return CGPointMake(2/(r+1)*point.y, 
                       2/(r+1)*point.x);
}

+(CGPoint)Handkerchief:(CGPoint)point{
    float r=sqrtf(point.x*point.x+point.y*point.y);
    float theta=atan2f(point.x, point.y);
    return CGPointMake(r*sinf(r+theta), 
                       r*cosf(r-theta));
}

-(CGPoint) caculate:(CGPoint)point{
    int index=arc4random()%5;
    switch (index) {
        case 0:
            point.x=point.x*[[parameter objectAtIndex:0] floatValue]+point.y*[[parameter objectAtIndex:1] floatValue]+[[parameter objectAtIndex:2] floatValue];
            point.y=point.x*[[parameter objectAtIndex:3] floatValue]+point.y*[[parameter objectAtIndex:4] floatValue]+[[parameter objectAtIndex:5] floatValue];
            return [IFSFunctions Sinusodial:point];
            break;
        
        case 1:
            point.x=point.x*[[parameter objectAtIndex:6] floatValue]+point.y*[[parameter objectAtIndex:7] floatValue]+[[parameter objectAtIndex:8] floatValue];
            point.y=point.x*[[parameter objectAtIndex:9] floatValue]+point.y*[[parameter objectAtIndex:10] floatValue]+[[parameter objectAtIndex:11] floatValue];
            return [IFSFunctions Spherical:point];
            break;
        
        case 2:
            point.x=point.x*[[parameter objectAtIndex:12] floatValue]+point.y*[[parameter objectAtIndex:13] floatValue]+[[parameter objectAtIndex:14] floatValue];
            point.y=point.x*[[parameter objectAtIndex:15] floatValue]+point.y*[[parameter objectAtIndex:16] floatValue]+[[parameter objectAtIndex:17] floatValue];            return [IFSFunctions Swirl:point];
            break;
            
        case 3:
            point.x=point.x*[[parameter objectAtIndex:18] floatValue]+point.y*[[parameter objectAtIndex:19] floatValue]+[[parameter objectAtIndex:20] floatValue];
            point.y=point.x*[[parameter objectAtIndex:21] floatValue]+point.y*[[parameter objectAtIndex:22] floatValue]+[[parameter objectAtIndex:23] floatValue];
            return [IFSFunctions FishEye:point];
            break;
            
        case 4:
            point.x=point.x*[[parameter objectAtIndex:24] floatValue]+point.y*[[parameter objectAtIndex:25] floatValue]+[[parameter objectAtIndex:26] floatValue];
            point.y=point.x*[[parameter objectAtIndex:27] floatValue]+point.y*[[parameter objectAtIndex:28] floatValue]+[[parameter objectAtIndex:29] floatValue];
            return [IFSFunctions Handkerchief:point];
            break;
            
        default:
            break;
    }
}
@end
