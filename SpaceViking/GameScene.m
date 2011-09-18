//
//  GameScene.m
//  SpaceViking
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(id)init{
    self=[super init];
    if(self != nil)
    {
        BackgroundLayer *backgroundLayer=[BackgroundLayer node];
        GameplayLayer *gameplayLayer=[GameplayLayer node];
        [self addChild:backgroundLayer z:0];
        [self addChild:gameplayLayer z:5];
    }
    return self;
}

@end
