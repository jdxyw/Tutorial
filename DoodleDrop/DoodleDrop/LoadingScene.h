//
//  LoadingScene.h
//  DoodleDrop
//
//  Created by jdxyw on 11-9-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
    TargetSceneIVALID=0,
    TargetSceneFirstScene,
    TargetSceneOtherScene,
    TargetSceneMax,
}TargetScenes;

@interface LoadingScene : CCScene {
    TargetScenes targetScene_;
}

+(id)sceneWithTargetScene:(TargetScenes)targetScene;
-(id)initWithTargetScene:(TargetScenes)targetScene;

@end
