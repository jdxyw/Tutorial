//
//  ImageProcessingByOpenGLESViewController.h
//  ImageProcessingByOpenGLES
//
//  Created by jdxyw on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ImageProcessingByOpenGLESViewController : UIViewController {
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    
    GLuint texture;
    
    GLuint _texCoordSlot;
    GLuint _textureUniform;
    GLuint _texOffset;
    GLuint _time;
    GLuint _resloution;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
