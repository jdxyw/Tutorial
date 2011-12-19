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
@synthesize color;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        parameter=[[NSMutableArray alloc] init];
        for (int i=0; i<64; i++) {
            [parameter addObject:[NSNumber numberWithFloat:arc4random()*2.0/ARC4RANDOM_MAX-1.0]];
        }
        color=[[NSMutableArray alloc] init];
        for (int i=0; i<11; i++) {
            UIColor *color1=[self colorfunction:i];
            const CGFloat *c=CGColorGetComponents(color1.CGColor);
            NSArray *arrColor=[[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:c[0]],[NSNumber numberWithFloat:c[1]],[NSNumber numberWithFloat:c[2]], nil];
            [color addObject:arrColor];
        }
    }
    
    return self;
}

-(UIColor *)colorfunction:(int)type{
    return [UIColor colorWithHue:1.0/(type+1) saturation:1.0 brightness:1.0 alpha:1.0];
}

-(DataPoint) Sinusodial:(DataPoint)point{
    DataPoint p;
    p.p=CGPointMake(sinf(point.p.x), sinf(point.p.y));
    p.red=([[[color objectAtIndex:0] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:0] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:0] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint) Spherical:(DataPoint)point{
    float r=point.p.x*point.p.x+point.p.y*point.p.y;
    DataPoint p;
    p.p=CGPointMake(point.p.x/r, point.p.y/r);
    p.red=([[[color objectAtIndex:1] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:1] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:1] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint) Swirl:(DataPoint)point{
    float r=point.p.x*point.p.x+point.p.y*point.p.y;
    DataPoint p;
    p.p=CGPointMake(point.p.x*sinf(r)-point.p.y*cosf(r), 
                    point.p.x*cosf(r)+point.p.y*sinf(r));
    p.red=([[[color objectAtIndex:2] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:2] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:2] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint) FishEye:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    DataPoint p;
    p.p=CGPointMake(2/(r+1)*point.p.y, 
                    2/(r+1)*point.p.x);
    p.red=([[[color objectAtIndex:3] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:3] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:3] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint)Handkerchief:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    DataPoint p;
    p.p=CGPointMake(r*sinf(r+theta), 
                    r*cosf(r-theta));
    p.red=([[[color objectAtIndex:4] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:4] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:4] objectAtIndex:2] floatValue]*255+point.blue)/2.0;    return p;
}

-(DataPoint)HorseShoe:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    DataPoint p;
    p.p=CGPointMake((point.p.x-point.p.y)*(point.p.x+point.p.y)/r, 2*point.p.x*point.p.y/r);
    p.red=([[[color objectAtIndex:5] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:5] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:5] objectAtIndex:2] floatValue]*255+point.blue)/2.0;    return p;
}

-(DataPoint)Polar:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    DataPoint p;
    p.p=CGPointMake(theta/3.1415926, r-1.0);
    p.red=([[[color objectAtIndex:6] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:6] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:6] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint)Heart:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    DataPoint p;
    p.p=CGPointMake(sinf(theta*r)*r, -cosf((theta*r)*r));
    p.red=([[[color objectAtIndex:7] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:7] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:7] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}
                       
-(DataPoint)Disc:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    DataPoint p;
    p.p=CGPointMake(sinf(r*3.1415926)*theta/3.1415926, cosf(r*3.1415926)*theta/3.1415926);
    p.red=([[[color objectAtIndex:8] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:8] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:8] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint)Diamond:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    DataPoint p;
    p.p=CGPointMake(sinf(theta)*cosf(r), cosf(theta)*sinf(r));
    p.red=([[[color objectAtIndex:9] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:9] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:9] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}

-(DataPoint)Ex:(DataPoint)point{
    float r=sqrtf(point.p.x*point.p.x+point.p.y*point.p.y);
    float theta=atan2f(point.p.x, point.p.y);
    float p0=sinf(theta+r);
    float p1=cosf(theta-r);
    DataPoint p;
    p.p=CGPointMake(r*(powf(p0, 3)+powf(p1, 3)), 
                    r*(powf(p0, 3)-powf(p1, 3)));
    p.red=([[[color objectAtIndex:10] objectAtIndex:0] floatValue] *255+point.red)/2.0;
    p.green=([[[color objectAtIndex:10] objectAtIndex:1] floatValue]*255+point.green)/2.0;
    p.blue=([[[color objectAtIndex:10] objectAtIndex:2] floatValue]*255+point.blue)/2.0;
    return p;
}


-(DataPoint) caculate:(DataPoint)point{
    int index=arc4random()%11;
    switch (index) {
        case 0:
            point.p.x=point.p.x*[[parameter objectAtIndex:0] floatValue]+point.p.y*[[parameter objectAtIndex:1] floatValue]+[[parameter objectAtIndex:2] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:3] floatValue]+point.p.y*[[parameter objectAtIndex:4] floatValue]+[[parameter objectAtIndex:5] floatValue];
            return [self Sinusodial:point];
            break;
        
        case 1:
            point.p.x=point.p.x*[[parameter objectAtIndex:6] floatValue]+point.p.y*[[parameter objectAtIndex:7] floatValue]+[[parameter objectAtIndex:8] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:9] floatValue]+point.p.y*[[parameter objectAtIndex:10] floatValue]+[[parameter objectAtIndex:11] floatValue];
            return [self Spherical:point];
            break;
        
        case 2:
            point.p.x=point.p.x*[[parameter objectAtIndex:12] floatValue]+point.p.y*[[parameter objectAtIndex:13] floatValue]+[[parameter objectAtIndex:14] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:15] floatValue]+point.p.y*[[parameter objectAtIndex:16] floatValue]+[[parameter objectAtIndex:17] floatValue];            
            return [self Swirl:point];
            break;
            
        case 3:
            point.p.x=point.p.x*[[parameter objectAtIndex:18] floatValue]+point.p.y*[[parameter objectAtIndex:19] floatValue]+[[parameter objectAtIndex:20] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:21] floatValue]+point.p.y*[[parameter objectAtIndex:22] floatValue]+[[parameter objectAtIndex:23] floatValue];
            return [self FishEye:point];
            break;
            
        case 4:
            point.p.x=point.p.x*[[parameter objectAtIndex:24] floatValue]+point.p.y*[[parameter objectAtIndex:25] floatValue]+[[parameter objectAtIndex:26] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:27] floatValue]+point.p.y*[[parameter objectAtIndex:28] floatValue]+[[parameter objectAtIndex:29] floatValue];
            return [self Handkerchief:point];
            break;
            
        case 5:
            point.p.x=point.p.x*[[parameter objectAtIndex:30] floatValue]+point.p.y*[[parameter objectAtIndex:31] floatValue]+[[parameter objectAtIndex:32] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:33] floatValue]+point.p.y*[[parameter objectAtIndex:34] floatValue]+[[parameter objectAtIndex:35] floatValue];
            return [self HorseShoe:point];
            break;
            
        case 6:
            point.p.x=point.p.x*[[parameter objectAtIndex:36] floatValue]+point.p.y*[[parameter objectAtIndex:37] floatValue]+[[parameter objectAtIndex:38] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:39] floatValue]+point.p.y*[[parameter objectAtIndex:40] floatValue]+[[parameter objectAtIndex:41] floatValue];
            return [self Polar:point];
            break;
            
        case 7:
            point.p.x=point.p.x*[[parameter objectAtIndex:42] floatValue]+point.p.y*[[parameter objectAtIndex:43] floatValue]+[[parameter objectAtIndex:44] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:45] floatValue]+point.p.y*[[parameter objectAtIndex:46] floatValue]+[[parameter objectAtIndex:47] floatValue];
            return [self Heart:point];
            break;
            
        case 8:
            point.p.x=point.p.x*[[parameter objectAtIndex:48] floatValue]+point.p.y*[[parameter objectAtIndex:49] floatValue]+[[parameter objectAtIndex:50] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:51] floatValue]+point.p.y*[[parameter objectAtIndex:52] floatValue]+[[parameter objectAtIndex:53] floatValue];
            return [self Disc:point];
            break;
            
        case 9:
            point.p.x=point.p.x*[[parameter objectAtIndex:53] floatValue]+point.p.y*[[parameter objectAtIndex:54] floatValue]+[[parameter objectAtIndex:55] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:56] floatValue]+point.p.y*[[parameter objectAtIndex:57] floatValue]+[[parameter objectAtIndex:58] floatValue];
            return [self Diamond:point];
            break;
            
        case 10:
            point.p.x=point.p.x*[[parameter objectAtIndex:59] floatValue]+point.p.y*[[parameter objectAtIndex:60] floatValue]+[[parameter objectAtIndex:61] floatValue];
            point.p.y=point.p.x*[[parameter objectAtIndex:51] floatValue]+point.p.y*[[parameter objectAtIndex:62] floatValue]+[[parameter objectAtIndex:63] floatValue];
            return [self Ex:point];
            break;

            
        default:
            break;
    }
}
@end
