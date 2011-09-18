//
//  GameplayLayer.m
//  SpaceViking
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameplayLayer.h"


@implementation GameplayLayer

-(void)initJoyStickAndButton{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    CGRect joystickBaseDimensions=CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect jumpButtonDimensions=CGRectMake(0, 0, 64, 64);
    CGRect attackButtonDimensions=CGRectMake(0, 0, 64, 64);
    CGPoint joystickbasePoint=CGPointMake(screenSize.width*0.07f, screenSize.height*0.11f);
    CGPoint jumpButtonPoint=CGPointMake(screenSize.width*0.93f, screenSize.height*0.11f);
    CGPoint attackButtonPoint=CGPointMake(screenSize.width*0.93f, screenSize.height*0.35);
    
    SneakyJoystickSkinnedBase *joystickbase=[[[SneakyJoystickSkinnedBase alloc]init] autorelease];
    joystickbase.position=joystickbasePoint;
    joystickbase.backgroundSprite=[CCSprite spriteWithFile:@"dpadDown.png"];
    joystickbase.thumbSprite=[CCSprite spriteWithFile:@"joystickDown.png"];
    joystickbase.joystick=[[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    leftJoyStick=[joystickbase.joystick retain];
    [self addChild:joystickbase];
    
    SneakyButtonSkinnedBase *jumpButtonBase=[[[SneakyButtonSkinnedBase alloc] init] autorelease];
    jumpButtonBase.position=jumpButtonPoint;
    jumpButtonBase.defaultSprite=[CCSprite spriteWithFile:@"jumpUp.png"];
    jumpButtonBase.activatedSprite=[CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.pressSprite=[CCSprite spriteWithFile:@"jumpDown.png"];
    jumpButtonBase.button=[[SneakyButton alloc] initWithRect:jumpButtonDimensions];
    jumpButton=[jumpButtonBase.button retain];
    jumpButton.isToggleable=YES;
    [self addChild:jumpButtonBase];
    
    SneakyButtonSkinnedBase *attackButtonBase=[[[SneakyButtonSkinnedBase alloc] init] autorelease];
    attackButtonBase.position=attackButtonPoint;
    attackButtonBase.defaultSprite=[CCSprite spriteWithFile:@"handUp.png"];
    attackButtonBase.activatedSprite=[CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.pressSprite=[CCSprite spriteWithFile:@"handDown.png"];
    attackButtonBase.button=[[SneakyButton alloc] initWithRect:attackButtonDimensions];
    attackButton=[attackButtonBase.button retain];
    attackButton.isToggleable=NO;
    [self addChild:attackButtonBase];
}

-(void)applyJoyStick:(SneakyJoystick *)aJoyStick toNode:(CCNode*)tempNode forTimeDelta:(float)deltatime
{
    CGPoint scaledVelocity=ccpMult(aJoyStick.velocity, 256.0f);
    CGPoint newPos=CGPointMake(tempNode.position.x+scaledVelocity.x*deltatime, tempNode.position.y+scaledVelocity.y*deltatime);
    [tempNode setPosition:newPos];
    if(jumpButton.active==YES)
    {
        CCLOG(@"Jump button is pressed");
    }
    if(attackButton.active==YES)
    {
        CCLOG(@"Attack button is pressed");
    }
}

-(void)update:(ccTime)deltatime
{
    [self applyJoyStick:leftJoyStick toNode:vikingSpirite forTimeDelta:deltatime];
}

-(id)init{
    self=[super init];
    if(self !=nil)
    {
        CGSize screenSize=[[CCDirector sharedDirector] winSize];
        self.isTouchEnabled=YES;
        //vikingSpirite=[CCSprite spriteWithFile:@"sv_anim_1.png"];
        
        CCSpriteBatchNode *chapter2SpriteBatchNode;
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"scene1atlasiPhone.plist"];
        chapter2SpriteBatchNode=[CCSpriteBatchNode batchNodeWithFile:@"scene1atlasiPhone.png"];
        vikingSpirite=[CCSprite spriteWithSpriteFrameName:@"sv_anim_1.png"];
        [chapter2SpriteBatchNode addChild:vikingSpirite];
        [vikingSpirite setPosition:CGPointMake(screenSize.width/2, screenSize.height*0.17f)];
        
//        CCSprite *animatingRobot=[CCSprite spriteWithFile:@"an1_anim1.png"];
//        [animatingRobot setPosition:CGPointMake([vikingSpirite position].x+50.0f, [vikingSpirite position].y)];
//        [self addChild:animatingRobot];
//        
//        CCAnimation *robotAnim=[CCAnimation animation];
//        [robotAnim addFrameWithFilename:@"an1_anim2.png"];
//        [robotAnim addFrameWithFilename:@"an1_anim3.png"];
//        [robotAnim addFrameWithFilename:@"an1_anim4.png"];
        
        CCSprite *animatingRobot=[CCSprite spriteWithSpriteFrameName:@"an1_anim1.png"];
        [chapter2SpriteBatchNode addChild:animatingRobot];
        [animatingRobot setPosition:CGPointMake([vikingSpirite position].x+50.0f, [vikingSpirite position].y)];
        CCAnimation *robotAnim=[CCAnimation animation];
        [robotAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim2.png"]];
        [robotAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim3.png"]];
        [robotAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim4.png"]];
        [robotAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim5.png"]];
        [robotAnim addFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"an1_anim6.png"]];
        
        id robotAnimationAction=[CCAnimate actionWithDuration:0.5f animation:robotAnim restoreOriginalFrame:YES];
        id repetRobotAnimation=[CCRepeatForever actionWithAction:robotAnimationAction];
        [animatingRobot runAction:repetRobotAnimation];
        //[self addChild:vikingSpirite];
        
        [self addChild:chapter2SpriteBatchNode];
        [self initJoyStickAndButton];
        [self scheduleUpdate];
    }
    return self;
}

@end
