//
//  SwitchFBOViewController.m
//  SwitchFBO
//
//  Created by jdxyw on 11-11-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SwitchFBOViewController.h"
#import "EAGLView.h"

// Uniform index.
enum {
    NORMAL_TEXT,
    AUTOMATE_TEXT,
    DU,
    DV,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    ATTRIB_TEXCOORD,
    ATTRIB_VERTEX_2,
    ATTRIB_TEXCOORD_2,
    NUM_ATTRIBUTES
};

@interface SwitchFBOViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation SwitchFBOViewController

@synthesize animating;
@synthesize context;
@synthesize displayLink;

- (void)awakeFromNib
{
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext) {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    
    glEnable(GL_TEXTURE_2D);
    glGenTextures(1, &textureA);
    glBindTexture(GL_TEXTURE_2D, textureA);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 256, 256, 0, GL_RGBA,
                 GL_UNSIGNED_BYTE, NULL);
    
    glGenTextures(1, &textureB);
    glBindTexture(GL_TEXTURE_2D, textureB);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    data=(GLubyte*)malloc(256*256*4*sizeof(GLubyte));
    GLubyte val;
    for (int i = 0; i < 256 * 256 * 4; i+=4) {   
        if (rand()%10 ==1) 
            { val = 0; } 
        else 
            { val = 255; }
        data[i] = data[i+1] = data[i+2] = val;
        data[i+3] = 255;
    }
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 256, 256, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    glGenFramebuffers(1, &fboA);
    glBindFramebuffer(GL_FRAMEBUFFER, fboA);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureA, 0);
    
    glGenFramebuffers(1, &fboB);
    glBindFramebuffer(GL_FRAMEBUFFER, fboB);
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureB, 0);
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
}

- (void)dealloc
{
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1) {
        animationFrameInterval = frameInterval;
        
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating) {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}

- (void)drawFrame
{
    
    // Replace the implementation of this method to do your own custom drawing.
    static const GLfloat squareVertices[] = {
        -1.0f, -1.0f,
        1.0f, -1.0f,
        -1.0f,  1.0f,
        1.0f,  1.0f,
    };
    
    static const GLubyte squareColors[] = {
        255, 255,   0, 255,
        0,   255, 255, 255,
        0,     0,   0,   0,
        255,   0, 255, 255,
    };
    
    static const GLfloat texCoord[]={
        0,1,
        1,1,
        0,0,
        1,0  
    };

    static int counter=0;
    static float transY = 0.0f;
    
        
    if ([context API] == kEAGLRenderingAPIOpenGLES2) {
        
        
        if(counter%2==0)
        {
            glUseProgram(automateProg);
            glBindFramebuffer(GL_FRAMEBUFFER, fboA);
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, textureB);
            glUniform1i(AUTOMATE_TEXT, 0);
            glUniform1f(DU, 1.0/256);
            glUniform1f(DV, 1.0/256);
            // Update attribute values.
            glVertexAttribPointer(ATTRIB_VERTEX_2, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX_2);
            
            glVertexAttribPointer(ATTRIB_TEXCOORD_2, 2, GL_FLOAT, GL_FALSE, 0, texCoord);    
            //glEnableVertexAttribArray(ATTRIB_TEXCOORD_2);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            if (![self validateProgram:automateProg]) {
                NSLog(@"Failed to validate program: %d", automateProg);
                return;
            }
            
            glBindFramebuffer(GL_FRAMEBUFFER, 0);
            glUseProgram(0);
        }
        else
        {
            glUseProgram(automateProg);            
            glBindFramebuffer(GL_FRAMEBUFFER, fboB);
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, textureA);
            glUniform1i(AUTOMATE_TEXT, 0);
            glUniform1f(DU, 1.0/256);
            glUniform1f(DV, 1.0/256);
            // Update attribute values.
            glVertexAttribPointer(ATTRIB_VERTEX_2, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX_2);
            glVertexAttribPointer(ATTRIB_TEXCOORD_2, 2, GL_FLOAT, GL_FALSE, 0, texCoord); 
            //glEnableVertexAttribArray(ATTRIB_TEXCOORD_2);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            if (![self validateProgram:automateProg]) {
                NSLog(@"Failed to validate program: %d", automateProg);
                return;
            }
            
            glBindFramebuffer(GL_FRAMEBUFFER, 0);
            glUseProgram(0);
        }
        
        //glBindFramebuffer(GL_FRAMEBUFFER, [(EAGLView*)self.view defaultFramebuffer]);
        [(EAGLView *)self.view setFramebuffer];
        glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        if (counter % 2 == 0) {
            glUseProgram(normalProg);
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, textureB);
            glUniform1i(NORMAL_TEXT, 0);
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
            glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 0, texCoord); 
            glEnableVertexAttribArray(ATTRIB_TEXCOORD);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            if (![self validateProgram:normalProg]) {
                NSLog(@"Failed to validate program: %d", normalProg);
                return;
            }
            glUseProgram(0);

        } else {
            glUseProgram(normalProg);
            glActiveTexture(GL_TEXTURE0);
            glBindTexture(GL_TEXTURE_2D, textureA);
            glUniform1i(NORMAL_TEXT, 0);
            glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
            glEnableVertexAttribArray(ATTRIB_VERTEX);
            glVertexAttribPointer(ATTRIB_TEXCOORD, 2, GL_FLOAT, GL_FALSE, 0, texCoord); 
            glEnableVertexAttribArray(ATTRIB_TEXCOORD);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            if (![self validateProgram:normalProg]) {
                NSLog(@"Failed to validate program: %d", normalProg);
                return;
            }
            glUseProgram(0);
        }
        counter++;
        sleep(1);
        // Use shader program.
       // glUseProgram(program);
        
        // Update uniform value.
        //glUniform1f(uniforms[UNIFORM_TRANSLATE], (GLfloat)transY);
        //transY += 0.075f;	
        
        
        
        // Validate program before drawing. This is a good check, but only really necessary in a debug build.
        // DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
        //if (![self validateProgram:program]) {
        //    NSLog(@"Failed to validate program: %d", program);
        //    return;
        //}
#endif
    } else {
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
        glTranslatef(0.0f, (GLfloat)(sinf(transY)/2.0f), 0.0f);
        transY += 0.075f;
        
        glVertexPointer(2, GL_FLOAT, 0, squareVertices);
        glEnableClientState(GL_VERTEX_ARRAY);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, squareColors);
        glEnableClientState(GL_COLOR_ARRAY);
    }
    
    
    [(EAGLView *)self.view presentFramebuffer];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;
    
    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    NSString *automatevertShader, *automatefragShader;
    // Create shader program.
    normalProg = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(normalProg, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(normalProg, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(normalProg, ATTRIB_VERTEX, "position");
    //glBindAttribLocation(normalProg, ATTRIB_COLOR, "color");
    glBindAttribLocation(normalProg, ATTRIB_TEXCOORD, "textCoord");
    
    
    // Get uniform locations.
    uniforms[NORMAL_TEXT] = glGetUniformLocation(normalProg, "tex");
    
    // Link program.
    if (![self linkProgram:normalProg])
    {
        NSLog(@"Failed to link program: %d", normalProg);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (normalProg)
        {
            glDeleteProgram(normalProg);
            program = 0;
        }
        
        return FALSE;
    }
    
    
    // Release vertex and fragment shaders.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    
    automateProg = glCreateProgram();
    
    // Create and compile vertex shader.
    //automatevertShader = [[NSBundle mainBundle] pathForResource:@"automate" ofType:@"vsh"];
    automatevertShader=[NSString stringWithString:@"/Users/jdxyw/Documents/App/Tutorial/SwitchFBO/SwitchFBO/Shaders/automate.vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:automatevertShader])
    {
        NSLog(@"Failed to compile automate vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    //automatefragShader = [[NSBundle mainBundle] pathForResource:@"automate" ofType:@"fsh"];
    automatefragShader=[NSString stringWithString:@"/Users/jdxyw/Documents/App/Tutorial/SwitchFBO/SwitchFBO/Shaders/automate.fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:automatefragShader])
    {
        NSLog(@"Failed to compile automate fragment shader");
        return FALSE;
    }

    glAttachShader(automateProg, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(automateProg, fragShader);
    
    glBindAttribLocation(automateProg, ATTRIB_VERTEX_2, "a_position");
    glBindAttribLocation(automateProg, ATTRIB_TEXCOORD_2, "a_texCoord");
    
    uniforms[AUTOMATE_TEXT] = glGetUniformLocation(automateProg, "tex");
    uniforms[DU] = glGetUniformLocation(automateProg, "du");
    uniforms[DV] = glGetUniformLocation(automateProg, "dv");
    
    // Link program.
    if (![self linkProgram:automateProg])
    {
        NSLog(@"Failed to link program: %d", automateProg);
        
        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (automateProg)
        {
            glDeleteProgram(automateProg);
            automateProg = 0;
        }
        
        return FALSE;
    }

    
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);

    
    return TRUE;
}

@end
