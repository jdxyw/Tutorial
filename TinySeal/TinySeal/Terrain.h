//
//  Terrain.h
//  TinySeal
//
//  Created by jdxyw on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class HelloWorldLayer;

#define kMaxHillKeyPoints 1000
#define kHillSegmentWidth 10
#define kMaxHillVertices 4000
#define kMaxBorderVertices 800

@interface Terrain : CCNode {
    int _offsetX;
    CGPoint _hillKeyPoint[kMaxHillKeyPoints];
    CCSprite *_stripes;
    int fromKeyPoint;
    int toKeyPoint;
    
    int _nHillVertices;
    CGPoint _hillVertices[kMaxHillVertices];
    CGPoint _hillTexCoords[kMaxHillVertices];
    int _nBorderVertices;
    CGPoint _borderVertices[kMaxBorderVertices];
}

@property (retain) CCSprite *_stripes;
-(void)setOffsetX:(float)newOffsetX;

@end
