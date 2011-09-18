//
//  GameScene.m
//  DoodleDrop
//
//  Created by jdxyw on 11-9-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SimpleAudioEngine.h"


@implementation GameScene

+(id)scene{
    CCScene *scene=[CCScene node];
    CCLayer *layer=[GameScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if(self=[super init])
    {
        self.isAccelerometerEnabled=YES;
        player=[CCSprite spriteWithFile:@"alien.png"];
        [self addChild:player z:0 tag:1];
        
        CGSize screensize=[[CCDirector sharedDirector] winSize];
        float imageheight=[player texture].contentSize.height;
        player.position=CGPointMake(screensize.width/2, imageheight/2);
        [self initSpider];
        [self scheduleUpdate];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"blues.mp3" loop:YES];
        [[SimpleAudioEngine sharedEngine] playEffect:@"alien-sfx.caf"];
    }
    return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float deceleartion=0.4;
    float sensitivity=0.6;
    float maxVelocity=100;
    playerVelocity.x=playerVelocity.x*deceleartion+acceleration.x*sensitivity;
    if(playerVelocity.x>maxVelocity)
    {
        playerVelocity.x=maxVelocity;
    }
    else if(playerVelocity.x < -maxVelocity)
    {
        playerVelocity.x=-maxVelocity;
    }
    
//    CGPoint pos=player.position;
//    pos.x += acceleration.x*10;
//    player.position=pos;
}

-(void)initSpider{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    CCSprite *tempSpider=[CCSprite spriteWithFile:@"spider.png"];
    float imagewidth=[tempSpider texture].contentSize.width;
    int numspiders=screenSize.width/imagewidth;
    spiders=[[CCArray alloc] initWithCapacity:numspiders];
    
    for(int i=0;i<numspiders;i++)
    {
        CCSprite *Spider=[CCSprite spriteWithFile:@"spider.png"];
        [self addChild:Spider z:0 tag:2];
        [spiders addObject:Spider];
    }
    [self resetSpider];
    
}

-(void)spiderUpdate:(ccTime)delta{
    for(int i=0;i<10;i++)
    {
        int randomSpiderIndex=CCRANDOM_0_1()*[spiders count];
        CCSprite *spider=[spiders objectAtIndex:randomSpiderIndex];
        if([spider numberOfRunningActions]==0)
        {
            [self runSpiderMoveSequence:spider];
            break;
        }
    }
}


-(void)resetSpider{
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    CCSprite *tempSpider=[spiders lastObject];
    CGSize size=[tempSpider texture].contentSize;
    
    int numSpiders=[spiders count];
    for(int i=0;i<numSpiders;i++)
    {
        CCSprite *spider=[spiders objectAtIndex:i];
        spider.position=CGPointMake(size.width*i+size.width*0.5f, screenSize.height+size.height);
        [spider stopAllActions];
    }
    [self unschedule:@selector(spiderUpdate:)];
    [self schedule:@selector(spiderUpdate:) interval:0.7f];
    
    numSpiderMoved=0;
    spiderMoveDuration=1.5;

}


-(void)runSpiderMoveSequence:(CCSprite *)spider
{
    numSpiderMoved++;
    if(numSpiderMoved % 8 ==0 && spiderMoveDuration>2.0f)
    {
        spiderMoveDuration -= 0.1f;
    }
    
    CGPoint belowScreenPos=CGPointMake(spider.position.x, -[spider texture].contentSize.height);
    CCMoveTo *move=[CCMoveTo actionWithDuration:spiderMoveDuration position:belowScreenPos];
    CCCallFuncN *call=[CCCallFuncN actionWithTarget:self selector:@selector(spiderBelowScreen:)];
    CCSequence *sequence=[CCSequence actions:move, call, nil];
    [spider runAction:sequence];
}

-(void)spiderBelowScreen:(id)sender
{
    CCSprite *spider=(CCSprite*) sender;
    CGPoint pos=spider.position;
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    pos.y=screenSize.height+[spider texture].contentSize.height;
    spider.position=pos;
}

-(void)checkforCollision{
    float playerImageSize=[player texture].contentSize.width;
    float spiderImageSize=[[spiders lastObject] texture].contentSize.width;
    float playerCollisionRadius=playerImageSize*0.4f;
    float spiderCollisionRadius=spiderImageSize*0.4f;
    
    float mexCollisionRadius=playerCollisionRadius+spiderCollisionRadius;
    int spiderNums=[spiders count];
    for(int i=0;i<spiderNums;i++)
    {
        CCSprite *spider=[spiders objectAtIndex:i];
        if([spider numberOfRunningActions]==0)
        {
            continue;
        }
        float actualDistance=ccpDistance(player.position, spider.position);
        if(actualDistance<mexCollisionRadius)
        {
            [self resetSpider];
        }
    }
}

-(void)update:(ccTime)delta
{
    CGPoint pos=player.position;
    pos.x += playerVelocity.x;
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    float imageWidthHalf=[player texture].contentSize.width*0.5f;
    float leftBorderLimit=imageWidthHalf;
    float rightBorderLimit=screenSize.width-imageWidthHalf;
    if(pos.x < leftBorderLimit)
    {
        pos.x=leftBorderLimit;
        playerVelocity=CGPointZero;
    }
    else if(pos.x>rightBorderLimit)
    {
        pos.x=rightBorderLimit;
        playerVelocity=CGPointZero;
    }
    player.position=pos;
    [self checkforCollision];
}

-(void)dealloc{
    [spiders release];
    [super dealloc];
}

@end
