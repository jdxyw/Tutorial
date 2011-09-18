//
//  GameplayLayer.h
//  SpaceViking
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"

@interface GameplayLayer : CCLayer {
    CCSprite *vikingSpirite;
    SneakyJoystick *leftJoyStick;
    SneakyButton *jumpButton;
    SneakyButton *attackButton;
}

@end
