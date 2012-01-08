//
//  PlaneDeformationController.m
//  GPUBase
//
//  Created by jdxyw on 11-12-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "PlaneDeformationController.h"
#import "EAGLView.h"
#import <QuartzCore/QuartzCore.h>
//#import "QuadCurveMenu.h"

enum {
    ATTRIB_VERTEX,
    ATTRIB_TEXTURE,
    NUM_ATTRIBUTES
};


@implementation PlaneDeformationController

@synthesize animating;
@synthesize context;
//@synthesize displayLink;
@synthesize vertexfile;
@synthesize fragmentfile;
@synthesize prelocation;
@synthesize step;
@synthesize initialDistance;
@synthesize scale;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) init{
    if(self=[super init])
    {
        

        
    }
    return self;
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
//    [menu release];
//    [glView release];
//    [context release];
//    [vertexfile release];
//    [fragmentfile release];
    //[super dealloc];
}

-(void)setFileName:(NSString *)vertex fragment:(NSString *)fragment{
    vertexfile=[NSString stringWithString:vertex];
    fragmentfile=[NSString stringWithString:fragment];
}

-(void)viewDidLoad
{
    glView=[[EAGLView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    glView.tag=101;
    [self.view addSubview:glView];
    
//    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
//    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
//    
//    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
//    
//    QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage 
//                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage 
//                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage 
//                                                        highlightedContentImage:nil];
//    QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
//                                                               highlightedImage:storyMenuItemImagePressed 
//                                                                   ContentImage:starImage 
//                                                        highlightedContentImage:nil];
//    
//    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
//    [starMenuItem1 release];
//    [starMenuItem2 release];
//    [starMenuItem3 release];
//    [starMenuItem4 release]; 
//    
//    menu = [[QuadCurveMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 480) menus:menus];
//    //[menu setCenter:CGPointMake(40, 420)];
//    //[menu setBounds:CGRectMake(0, 0, 120, 60)];
//    menu.delegate=self;
//    [self.view addSubview:menu];

    
    
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!aContext) {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	//[aContext release];
	
    [(EAGLView *)[self.view viewWithTag:101] setContext:context];
    [(EAGLView *)[self.view viewWithTag:101] setFramebuffer];
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2)
        [self loadShaders];
    
    prelocation=CGPointMake(0.0, 0.0);
    step=CGPointMake(0.0, 0.0);
    scale=1.0;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tex3" ofType:@"jpg"];
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    if (image == nil)
        NSLog(@"Do real error checking here");
    
    GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
    CGContextRef contextRef = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( contextRef, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( contextRef, 0, height - height );
    CGContextDrawImage( contextRef, CGRectMake( 0, 0, width, height ), image.CGImage );
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    
    CGContextRelease(contextRef);
    
    free(imageData);
    //[image release];
    //[texData release];
    
    
    animating = FALSE;
    animationFrameInterval = 5;
    displayLink = nil;
    t=0;
    Hide=NO;
    [self startAnimation];
    
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    
    [[self.view viewWithTag:101] addGestureRecognizer:pinchGesture];
    [[self.view viewWithTag:101] addGestureRecognizer:panGesture];
    
    [super viewDidLoad];
}

-(IBAction)handlePinchGesture:(id)sender{
    scale*=([(UIPinchGestureRecognizer*)sender scale]);
    
}

-(IBAction)handlePanGesture:(id)sender{
    CGPoint transform = [sender translationInView:[self.view viewWithTag:101]];
    CGSize size=[UIScreen mainScreen].bounds.size;
    step.x += (transform.x*0.2/size.width);
    step.y += (transform.y*0.2/size.height);
}
                                            
//- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
//{
//    NSLog(@"Select the index : %d",idx);
//    switch (idx) {
//        case 0:
//        {
//            unsigned char buffer[320*480*4];
//            glReadPixels(0,0,320,480,GL_RGBA,GL_UNSIGNED_BYTE,&buffer);
//            CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, &buffer, 320*480*4, NULL);
//            CGImageRef iref = CGImageCreate(320,480,8,32,320*4,CGColorSpaceCreateDeviceRGB(),kCGBitmapByteOrderDefault,ref,NULL,true,kCGRenderingIntentDefault);
//            
//            size_t width         = CGImageGetWidth(iref);
//            size_t height        = CGImageGetHeight(iref);
//            size_t length        = width*height*4;
//            uint32_t *pixels     = (uint32_t *)malloc(length);
//            CGContextRef contextImage = CGBitmapContextCreate(pixels, width, height, 8, width*4, CGImageGetColorSpace(iref),kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//            CGContextTranslateCTM(contextImage, 0.0, height);
//            CGContextScaleCTM(contextImage, 1.0, -1.0);
//            CGContextDrawImage(contextImage, CGRectMake(0.0, 0.0, width, height), iref);
//            CGImageRef outputRef = CGBitmapContextCreateImage(contextImage);
//            UIImage *outputImage = [UIImage imageWithCGImage:outputRef];
//            
//            UIImageWriteToSavedPhotosAlbum(outputImage, nil, nil, nil);
//            CGContextRelease(contextImage);
//            CGImageRelease(iref);
//            CGImageRelease(outputRef);
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

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
    
    [self stopAnimation];
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
        displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating) {
        [displayLink invalidate];
        displayLink = nil;
        animating = FALSE;
    }
}

- (void)drawFrame
{
    [(EAGLView *)[self.view viewWithTag:101] setFramebuffer];
    
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
    
    static float transY = 0.0f;
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    if ([context API] == kEAGLRenderingAPIOpenGLES2) {
        // Use shader program.
        glUseProgram(program);
        
        _textureUniform = glGetUniformLocation(program, "Texture");
        _time = glGetUniformLocation(program, "time");
        _resloution = glGetUniformLocation(program, "resolution");
        _transformation=glGetUniformLocation(program, "transform");
        _scale=glGetUniformLocation(program, "scale");
        // Update uniform value.
        //        glUniform1f(uniforms[UNIFORM_TRANSLATE], (GLfloat)transY);
        //        transY += 0.075f;	
        
        // Update attribute values.
        glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        
        
        glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, 0, texCoord);    
        
        glActiveTexture(GL_TEXTURE0); 
        glBindTexture(GL_TEXTURE_2D, texture);
        glUniform1i(_textureUniform, 0);
        
        //glUniform4f(_mouse, 0, 0, 0, 0);
        glUniform1f(_time, t);
        glUniform1f(_scale, 1.0/scale);
        t+=0.05;
        glUniform2f(_resloution, 320, 480);
        glUniform2f(_transformation, -step.x, step.y);
        // Validate program before drawing. This is a good check, but only really necessary in a debug build.
        // DEBUG macro must be defined in your debug configurations if that's not already the case.
#if defined(DEBUG)
        if (![self validateProgram:program]) {
            NSLog(@"Failed to validate program: %d", program);
            return;
        }
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
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    [(EAGLView *)[self.view viewWithTag:101] presentFramebuffer];
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
    
    // Create shader program.
    program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"fractal7" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"fractal7" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }
    
    // Attach vertex shader to program.
    glAttachShader(program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(program, ATTRIB_VERTEX, "position");
    //glBindAttribLocation(program, ATTRIB_COLOR, "color");
    //glBindAttribLocation(program, ATTRIB_COLOR, "TexCoordIn");
    
    // Link program.
    if (![self linkProgram:program])
    {
        NSLog(@"Failed to link program: %d", program);
        
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
        if (program)
        {
            glDeleteProgram(program);
            program = 0;
        }        return FALSE;
    }
    
    // Get uniform locations.
    //uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
    
    _texCoordSlot = glGetAttribLocation(program, "TexCoordIn");
    glEnableVertexAttribArray(_texCoordSlot);
    //_mouse = glGetUniformLocation(program, "mouse");
    
    // Release vertex and fragment shaders.
    if (vertShader)
        glDeleteShader(vertShader);
    if (fragShader)
        glDeleteShader(fragShader);
    
    return TRUE;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGRect				bounds = [self.view bounds];
//    UITouch*	touch = [[event touchesForView:self.view] anyObject];
//    
//    NSSet *allTouches=[event allTouches];
//    switch ([allTouches count]) {
//        case 1:
//            prelocation = [touch locationInView:self.view];
//            prelocation.y = bounds.size.height - prelocation.y;
//            break;
//        case 2:
//        {
//            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
//            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
//            
//            initialDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
//                                                     toPoint:[touch2 locationInView:[self view]]];
//        }
//            break;
//        default:
//            break;
//    }
//}
//
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGRect				bounds = [self.view bounds];
//    UITouch*	touch = [[event touchesForView:self.view] anyObject];
//	NSSet *allTouches=[event allTouches];
//    switch ([allTouches count]) {
//        case 1:
//        {
//            CGPoint current=[touch locationInView:self.view];
//            current.y = bounds.size.height - current.y;
//            
//            CGPoint temp;
//            
//            temp.x=-current.x+prelocation.x;
//            temp.y=-current.y+prelocation.y;
//            
//            step.x = step.x-temp.x/bounds.size.width;
//            step.y = step.y-temp.y/bounds.size.height;
//        }
//            break;
//            
//        case 2:
//        {
//            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
//            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
//            
//            //Calculate the distance between the two fingers.
//            CGFloat finalDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
//                                                           toPoint:[touch2 locationInView:[self view]]];
//            
//            //CGFloat dia=sqrtf(bounds.size.height*bounds.size.height+bounds.size.width*bounds.size.width);
//            if(finalDistance<initialDistance)
//            {
//                if(scale<10)
//                {
//                    scale=scale+logf(finalDistance)/logf(initialDistance);
//                    initialDistance=finalDistance;
//                }
//            }
//            else
//            {
//                if(scale>0.1)
//                {
//                    scale=scale-logf(finalDistance)/logf(initialDistance);
//                    initialDistance=finalDistance;
//                }
//                
//            }
//            
//        }
//            break;
//        default:
//            break;
//    }
//	
//    
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGRect				bounds = [self.view bounds];
//    UITouch*	touch = [[event touchesForView:self.view] anyObject];
//	NSSet *allTouches=[event allTouches];
//    switch ([allTouches count]) {
//        case 1:
//        {
//            CGPoint current=[touch locationInView:self.view];
//            current.y = bounds.size.height - current.y;
//            
//            CGPoint temp;
//            
//            temp.x=-current.x+prelocation.x;
//            temp.y=-current.y+prelocation.y;
//            
//            step.x = step.x-temp.x/bounds.size.width;
//            step.y = step.y-temp.y/bounds.size.height;
//            prelocation=current;
//        }
//            break;
//        case 2:
//        {
//            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
//            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
//            
//            //Calculate the distance between the two fingers.
//            CGFloat finalDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
//                                                           toPoint:[touch2 locationInView:[self view]]];
//            
//            //CGFloat dia=sqrtf(bounds.size.height*bounds.size.height+bounds.size.width*bounds.size.width);
//            if(finalDistance<initialDistance)
//            {
//                if(scale<10)
//                {
//                    scale=scale+logf(finalDistance)/logf(initialDistance);
//                    initialDistance=finalDistance;
//                }
//            }
//            else
//            {
//                if(scale>0.1)
//                {
//                    scale=scale-logf(finalDistance)/logf(initialDistance);
//                    initialDistance=finalDistance;
//                }
//
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//
//}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!Hide)
    {
        [UIView beginAnimations: nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        CGRect rect = CGRectMake(0, -44, 320, 44);
        self.navigationController.navigationBar.frame = rect;
        CGRect rect2=CGRectMake(0, 0, 320, 480);
        rect2.origin.y=-64;
        self.view.frame=rect2;
        [UIView commitAnimations];
        Hide=!Hide;
    }
    else
    {
        [UIView beginAnimations: nil context:NULL];
        [UIView setAnimationDuration:0.4];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        CGRect rect = CGRectMake(0, 20, 320, 44);
        self.navigationController.navigationBar.frame = rect;
        CGRect rect2=CGRectMake(0, 0, 320, 480);
        rect2.origin.y=0.0;
        self.view.frame=rect2;
        [UIView commitAnimations];
        Hide=!Hide;
    }
}

-(CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    float x = toPoint.x- fromPoint.x;
    float y = toPoint.y- fromPoint.y;
    
    return sqrt(x * x + y * y);
}
@end
