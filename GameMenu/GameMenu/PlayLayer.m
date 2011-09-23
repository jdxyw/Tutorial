//
//  PlayLayer.m
//  GameMenu
//
//  Created by jdxyw on 11-9-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlayLayer.h"


@implementation PlayLayer

-(id)init{
    self=[super init];
    if(!self)
    {
        return nil;
    }
    
    CCMenuItemFont *back=[CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
    CCMenu *menu=[CCMenu menuWithItems:back, nil];
    CGSize size=[[CCDirector sharedDirector] winSize];
    menu.position=CGPointMake(size.width/2, size.height/2);
    [self addChild:menu];
    return self;
}

-(void)back:(id)sender{
    [SceneManager goMenu];
}

@end
