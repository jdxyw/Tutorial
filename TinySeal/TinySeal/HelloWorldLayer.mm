//
//  HelloWorldLayer.mm
//  TinySeal
//
//  Created by jdxyw on 11-9-22.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"




// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(CCSprite*)strippedSpriteWithColor:(ccColor4F)bgColor color2:(ccColor4F)c2 textureSize:(float)textureSize stripes:(int)stripes{
    CCRenderTexture *rt=[CCRenderTexture renderTextureWithWidth:textureSize height:textureSize];
    [rt beginWithClear:bgColor.r g:bgColor.g b:bgColor.b a:bgColor.a];
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisableClientState(GL_COLOR_ARRAY);
    
    CGPoint vertices[stripes*6];
    int nVertices=0;
    float x1 = -textureSize;
    float x2;
    float y1 = textureSize;
    float y2 = 0;
    float dx = textureSize / stripes * 2;
    float stripeWidth = dx/2;
    for (int i=0; i<stripes; i++) {
        x2 = x1 + textureSize;
        vertices[nVertices++] = CGPointMake(x1, y1);
        vertices[nVertices++] = CGPointMake(x1+stripeWidth, y1);
        vertices[nVertices++] = CGPointMake(x2, y2);
        vertices[nVertices++] = vertices[nVertices-2];
        vertices[nVertices++] = vertices[nVertices-2];
        vertices[nVertices++] = CGPointMake(x2+stripeWidth, y2);
        x1 += dx;
    }
    
    glColor4f(c2.r, c2.g, c2.b, c2.a);
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glDrawArrays(GL_TRIANGLES, 0, (GLsizei)nVertices);
    
    // layer 2: gradient
    glEnableClientState(GL_COLOR_ARRAY);
    
    float gradientAlpha = 0.7;    
    ccColor4F colors[4];
    nVertices = 0;
    
    vertices[nVertices] = CGPointMake(0, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0 };
    vertices[nVertices] = CGPointMake(textureSize, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    vertices[nVertices] = CGPointMake(0, textureSize);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    vertices[nVertices] = CGPointMake(textureSize, textureSize);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_FLOAT, 0, colors);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);
    
    // layer 3: top highlight
    float borderWidth = textureSize/16;
    float borderAlpha = 0.3f;
    nVertices = 0;
    
    vertices[nVertices] = CGPointMake(0, 0);
    colors[nVertices++] = (ccColor4F){1, 1, 1, borderAlpha};
    vertices[nVertices] = CGPointMake(textureSize, 0);
    colors[nVertices++] = (ccColor4F){1, 1, 1, borderAlpha};
    
    vertices[nVertices] = CGPointMake(0, borderWidth);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    vertices[nVertices] = CGPointMake(textureSize, borderWidth);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_FLOAT, 0, colors);
    glBlendFunc(GL_DST_COLOR, GL_ONE_MINUS_SRC_ALPHA);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);
    
    glEnableClientState(GL_COLOR_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    CCSprite *noise=[CCSprite spriteWithFile:@"Noise.png"];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR,GL_ZERO}];
    noise.position=ccp(textureSize/2, textureSize/2);
    [noise visit];
    
    
    [rt end];
    return [CCSprite spriteWithTexture:rt.sprite.texture];


}

-(CCSprite*)spiriteWithColor:(ccColor4F)bgColor textureSize:(float)textureSize{
    CCRenderTexture *rt=[CCRenderTexture renderTextureWithWidth:textureSize height:textureSize];
    [rt beginWithClear:bgColor.r g:bgColor.g b:bgColor.b a:bgColor.a];
    
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    float gradientAlpha = 0.7; 
    CGPoint vertices[4];
    ccColor4F colors[4];
    int nVertices = 0;
    
    vertices[nVertices] = CGPointMake(0, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0 };
    vertices[nVertices] = CGPointMake(textureSize, 0);
    colors[nVertices++] = (ccColor4F){0, 0, 0, 0};
    vertices[nVertices] = CGPointMake(0, textureSize);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    vertices[nVertices] = CGPointMake(textureSize, textureSize);
    colors[nVertices++] = (ccColor4F){0, 0, 0, gradientAlpha};
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    glColorPointer(4, GL_FLOAT, 0, colors);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);
    
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_TEXTURE_2D);
    
    CCSprite *noise=[CCSprite spriteWithFile:@"Noise.png"];
    [noise setBlendFunc:(ccBlendFunc){GL_DST_COLOR,GL_ZERO}];
    noise.position=ccp(textureSize/2, textureSize/2);
    [noise visit];
    
    [rt end];
    return [CCSprite spriteWithTexture:rt.sprite.texture];
}


-(ccColor4F)randomBrightColor{
    while(true)
    {
        float requiredBright=192;
        ccColor4B randomColor4f=ccc4(arc4random()%255, arc4random()%255, arc4random()%255, 255);
        if(randomColor4f.r > requiredBright ||
           randomColor4f.g > requiredBright ||
           randomColor4f.b > requiredBright){
            return ccc4FFromccc4B(randomColor4f);
        }
    }
}

-(void)genBackground{
    [_background removeFromParentAndCleanup:YES];
    ccColor4F bgColor=[self randomBrightColor];
    ccColor4F color2=[self randomBrightColor];
    int nStripes = ((arc4random() % 4) + 1) * 2;
    //_background=[self spiriteWithColor:bgColor textureSize:512];
    _background=[self strippedSpriteWithColor:bgColor color2:color2 textureSize:512 stripes:nStripes];
    self.scale=0.5;
    CGSize size=[[CCDirector sharedDirector] winSize];
    _background.position=CGPointMake(size.width/2, size.height/2);
    
    ccTexParams tp={GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
    [_background.texture setTexParameters:&tp];
    
    [self addChild:_background z:-1];
}

// on "init" you need to initialize your instance
-(id) init
{
    if(self=[super init])
    {
        [self genBackground];
        self.isTouchEnabled=YES;
        [self scheduleUpdate];
    }
    return self;
}

-(void)update:(ccTime)dt{
    float PIXELS_PER_SECOND = 100;
    static float offset = 0;
    offset += PIXELS_PER_SECOND * dt;
    
    CGSize textureSize = _background.textureRect.size;
    [_background setTextureRect:CGRectMake(offset, 0, textureSize.width, textureSize.height)];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self genBackground];
}





// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[_background release];
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
