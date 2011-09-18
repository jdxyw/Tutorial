//
//  BackgroundLayer.m
//  SpaceViking
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer

-(id)init{
    self=[super init];
    CCSprite *background;
    if(self!=nil){
        background=[CCSprite spriteWithFile:@"backgroundiPhone.png"];
    }
    CGSize screen=[[CCDirector sharedDirector] winSize];
    [background setPosition:CGPointMake(screen.width/2, screen.height/2)];
    [self addChild:background z:0 tag:0];
    return self;
}

@end
