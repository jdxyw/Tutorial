//
//  LoadingScene.m
//  DoodleDrop
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "LoadingScene.h"


@implementation LoadingScene

+(id)sceneWithTargetScene:(TargetScenes)targetScene{
    return [[[self alloc] initWithTargetScene:targetScene] autorelease];
}

-(id)initWithTargetScene:(TargetScenes)targetScene{
    if(self=[super init])
    {
        targetScene_=targetScene;
        CCLabelTTF *label=[CCLabelTTF labelWithString:@"Loading..." fontName:@"Marker Felt" fontSize:64];
        CGSize size=[[CCDirector sharedDirector] winSize];
        label.position=CGPointMake(size.width/2, size.height/2);
        
        [self addChild:label];
        [self scheduleUpdate];
    }
    return self;
}

-(void)update:(ccTime)delta
{
    [self unscheduleAllSelectors];
    switch (targetScene_) {
        case TargetSceneFirstScene:
            break;
            
        default:
            break;
    }
}

@end
