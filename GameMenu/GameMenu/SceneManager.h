//
//  SceneManager.h
//  GameMenu
//
//  Created by jdxyw on 11-9-23.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "CreditLayer.h"
#import "PlayLayer.h"

@interface SceneManager : NSObject{
    
}

+(void)goMenu;
+(void)go:(CCLayer*)layer;
+(CCScene*)wrap:(CCLayer*)layer;
+(void)goPlay;
+(void)goCredit;

@end
