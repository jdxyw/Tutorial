//
//  SwitchFBOViewController.h
//  SwitchFBO
//
//  Created by jdxyw on 11-11-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface SwitchFBOViewController : UIViewController {
    EAGLContext *context;
    GLuint program;
    
    GLuint automateProg,normalProg;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    
    GLuint textureA,textureB,fboA,fboB;
    GLubyte* data;
    GLuint udu,udv;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
