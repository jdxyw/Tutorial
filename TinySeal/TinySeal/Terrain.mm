//
//  Terrain.m
//  TinySeal
//
//  Created by jdxyw on 11-9-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Terrain.h"


@implementation Terrain

@synthesize _stripes;

-(void)generateHill{
    CGSize size=[[CCDirector sharedDirector] winSize];
//    float x=0;
//    float y=size.width/2;
//    for(int i=0;i<kMaxHillKeyPoints;i++){
//        _hillKeyPoint[i]=CGPointMake(x, y);
//        x += size.width/2;
//        y =rand() % (int)size.height;
//    }
    
    float minDX=160;
    float minDY=60;
    int rangeDX=80;
    int rangeDY=40;
    
    float x=-minDX;
    float y = size.height/2-minDY;
    
    float dy, ny;
    float sign = 1; // +1 - going up, -1 - going down
    float paddingTop = 20;
    float paddingBottom = 20;

    for (int i=0; i<kMaxHillKeyPoints; i++) {
        _hillKeyPoint[i] = CGPointMake(x, y);
        if (i == 0) {
            x = 0;
            y = size.height/2;
        } else {
            x += rand()%rangeDX+minDX;
            while(true) {
                dy = rand()%rangeDY+minDY;
                ny = y + dy*sign;
                if(ny < size.height-paddingTop && ny > paddingBottom) {
                    break; 
                }
            }
            y = ny;
        }
        sign *= -1;
    }
    
}

-(void)draw{
//    for(int i=1;i<kMaxHillKeyPoints;i++){
//        ccDrawLine(_hillKeyPoint[i-1], _hillKeyPoint[i]);
//    }
    
    glBindTexture(GL_TEXTURE_2D, _stripes.texture.name);
    glDisableClientState(GL_COLOR_ARRAY);
    
    glColor4f(1, 1, 1, 1);
    glVertexPointer(2, GL_FLOAT, 0, _hillVertices);
    glTexCoordPointer(2, GL_FLOAT, 0, _hillTexCoords);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)_nHillVertices);
//    
//    for(int i = MAX(fromKeyPoint, 1); i <= toKeyPoint; ++i) {
//        glColor4f(1.0, 0, 0, 1.0); 
//        ccDrawLine(_hillKeyPoint[i-1], _hillKeyPoint[i]); 
//        
//        glColor4f(1.0, 1.0, 1.0, 1.0);
//        
//        CGPoint p0 = _hillKeyPoint[i-1];
//        CGPoint p1 = _hillKeyPoint[i];
//        int hSegments = floorf((p1.x-p0.x)/kHillSegmentWidth);
//        float dx = (p1.x - p0.x) / hSegments;
//        float da = M_PI / hSegments;
//        float ymid = (p0.y + p1.y) / 2;
//        float ampl = (p0.y - p1.y) / 2;
//        
//        CGPoint pt0, pt1;
//        pt0 = p0;
//        for (int j = 0; j < hSegments+1; ++j) {
//            
//            pt1.x = p0.x + j*dx;
//            pt1.y = ymid + ampl * cosf(da*j);
//            
//            ccDrawLine(pt0, pt1);
//            
//            pt0 = pt1;
//        }
//    }
}

-(void)resetHillVertices{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    static int prevFromKeyPointI = -1;
    static int prevToKeyPointI = -1;
    
    // key points interval for drawing
    while (_hillKeyPoint[fromKeyPoint+1].x < _offsetX-winSize.width/8/self.scale) {
        fromKeyPoint++;
    }
    while (_hillKeyPoint[toKeyPoint].x < _offsetX+winSize.width*9/8/self.scale) {
        toKeyPoint++;
    }
    
    if (prevFromKeyPointI != fromKeyPoint || prevToKeyPointI != toKeyPoint) {
        
        // vertices for visible area
        _nHillVertices = 0;
        _nBorderVertices = 0;
        CGPoint p0, p1, pt0, pt1;
        p0 = _hillKeyPoint[fromKeyPoint];
        for (int i=fromKeyPoint+1; i<toKeyPoint+1; i++) {
            p1 = _hillKeyPoint[i];
            
            // triangle strip between p0 and p1
            int hSegments = floorf((p1.x-p0.x)/kHillSegmentWidth);
            float dx = (p1.x - p0.x) / hSegments;
            float da = M_PI / hSegments;
            float ymid = (p0.y + p1.y) / 2;
            float ampl = (p0.y - p1.y) / 2;
            pt0 = p0;
            _borderVertices[_nBorderVertices++] = pt0;
            for (int j=1; j<hSegments+1; j++) {
                pt1.x = p0.x + j*dx;
                pt1.y = ymid + ampl * cosf(da*j);
                _borderVertices[_nBorderVertices++] = pt1;
                
                _hillVertices[_nHillVertices] = CGPointMake(pt0.x, 0);
                _hillTexCoords[_nHillVertices++] = CGPointMake(pt0.x/512, 1.0f);
                _hillVertices[_nHillVertices] = CGPointMake(pt1.x, 0);
                _hillTexCoords[_nHillVertices++] = CGPointMake(pt1.x/512, 1.0f);
                
                _hillVertices[_nHillVertices] = CGPointMake(pt0.x, pt0.y);
                _hillTexCoords[_nHillVertices++] = CGPointMake(pt0.x/512, 0);
                _hillVertices[_nHillVertices] = CGPointMake(pt1.x, pt1.y);
                _hillTexCoords[_nHillVertices++] = CGPointMake(pt1.x/512, 0);
                
                pt0 = pt1;
            }
            
            p0 = p1;
        }
        
        prevFromKeyPointI = fromKeyPoint;
        prevToKeyPointI = toKeyPoint; 
    }
}

-(void)setOffsetX:(float)newOffsetX{
    _offsetX=newOffsetX;
    self.position=CGPointMake(-_offsetX*self.scale, 0);
    [self resetHillVertices];
}



-(void)dealloc{
    [_stripes release];
    _stripes=NULL;
    [super dealloc];
}

-(id)init{
    if(self=[super init])
    {
        [self generateHill];
        [self resetHillVertices];
    }
    return self;
}

@end
