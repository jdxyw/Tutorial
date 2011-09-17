//
//  UIColor-Random.m
//  QuartzFun
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIColor-Random.h"

@implementation UIColor(Random)

+(UIColor *)randomColor
{
    static BOOL seeded=NO;
    if(seeded==NO)
    {
        seeded=YES;
        srandom(time(NULL));
    }
    
    CGFloat red=(CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue=(CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green=(CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
