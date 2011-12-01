//
//  PerlinNoiseViewController.h
//  PerlinNoise
//
//  Created by jdxyw on 11-12-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface PerlinNoiseViewController : UIViewController {
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    
    GLuint _texCoordSlot;
    GLuint _time;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
