//
//  SceneManager.m
//  GameMenu
//
//  Created by jdxyw on 11-9-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager

+(void)goMenu{
    CCLayer *menuLayer=[MenuLayer node];
    [SceneManager go:menuLayer];
}

+(void)goPlay{
    CCLayer *playLayer=[PlayLayer node];
    [SceneManager go:playLayer];
}

+(void)goCredit{
    CCLayer *creditLayer=[CreditLayer node];
    [SceneManager go:creditLayer];
}

+(void)go:(CCLayer *)layer{
    CCDirector *director=[CCDirector sharedDirector];
    CCScene *newScene=[self wrap:layer];
    if([director runningScene]){
        //[director replaceScene:newScene];
        [director replaceScene:[CCTransitionFade transitionWithDuration:1.2f scene:newScene withColor:ccBLACK]];
    }
    else
    {
        [director runWithScene:newScene];
    }
}

+(CCScene *)wrap:(CCLayer *)layer{
    CCScene *scene=[CCScene node];
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
