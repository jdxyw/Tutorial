//
//  HelloWorldLayer.h
//  TinySeal
//
//  Created by jdxyw on 11-9-22.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Terrain.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	CCSprite *_background;
    Terrain *_terrain;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
