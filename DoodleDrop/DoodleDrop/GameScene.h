//
//  GameScene.h
//  DoodleDrop
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCLayer {
    CCSprite *player;
    CGPoint playerVelocity;
    CCArray *spiders;
    float spiderMoveDuration;
    int numSpiderMoved;
}

+(id)scene;
-(void)initSpider;
-(void)resetSpider;
-(void)spiderUpdate:(ccTime)delta;
-(void)runSpiderMoveSequence:(CCSprite *)spider;
-(void)spiderBelowScreen:(id)sender;
-(void)checkforCollision;

@end
