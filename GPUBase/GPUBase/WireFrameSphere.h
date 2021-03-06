//
//  WireFrameSphere.h
//  GPUBase
//
//  Created by jdxyw on 11-12-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface WireFrameSphere : UIViewController
{
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    
    GLuint texture;
    
    GLuint _texCoordSlot;
    GLuint _textureUniform;
    
    GLuint _time;
    GLuint _resloution;
    
    NSString *vertexfile;
    NSString *fragmentfile;
    
    GLuint _offset;
    
    float interval;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
@property (nonatomic,retain) NSString *vertexfile;
@property (nonatomic,retain) NSString *fragmentfile;
@property (nonatomic) float interval;


- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
- (void)setFileName:(NSString *)vertex fragment:(NSString*)fragment;
- (void)setTimeInterval:(float)inter;

@end
