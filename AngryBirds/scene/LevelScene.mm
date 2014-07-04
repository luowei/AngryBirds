//
//  LevelScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene

+ (id) scene {
    CCScene *sc = [CCScene node];
    LevelScene *ls = [[LevelScene alloc] init];
    [sc addChild:ls];
    [ls release];
    return sc;
}

- (id) init {
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        // 放一个背景图片精灵
        CCSprite *sp = [CCSprite spriteWithFile:@"selectlevel.png"];
        sp.scaleX = winSize.width/sp.contentSize.width;
        sp.scaleY = winSize.height/sp.contentSize.height;
        sp.position = ccp(winSize.width/2.0f, winSize.height/2.0f);
        [self addChild:sp];
        // 放一个放回键的精灵
        CCSprite *backsp = [CCSprite spriteWithFile:@"backarrow.png"];
        backsp.position = ccp(40.0f, 40.0f);
        backsp.scale = 0.5f;
        backsp.tag = 100;
        [self addChild:backsp];
    }
    return self;
}

@end
