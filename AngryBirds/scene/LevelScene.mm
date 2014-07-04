//
//  LevelScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-4.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "LevelScene.h"
#import "GameUtils.h"

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
        
        // 加上14关
        successLevel = [GameUtils readLevelFromFile];;
        NSString *imgPath = nil;
        for (int i = 0; i < 16; i++) {
            if (i < successLevel) {
                // 已经通关的
                imgPath = @"level.png";
                NSString *str = [NSString stringWithFormat:
                                 @"%d", i+1];
                CCLabelTTF *numLabel = [CCLabelTTF labelWithString:str dimensions:CGSizeMake(60.0f, 60.0f) alignment:UITextAlignmentCenter fontName:@"Marker Felt" fontSize:30.0f];
                float x = 60+i%8*60;
                float y = 320-75-i/8*80;
                numLabel.position = ccp(x, y);
                [self addChild:numLabel z:2];
            } else {
                // 加锁的关卡
                imgPath = @"clock.png";
            }
            CCSprite *levelSprite = [CCSprite spriteWithFile:imgPath];
            // 设置图片精灵
            levelSprite.tag = i+1; // i+1为了避免tag为0
            float x = 60+i%8*60;
            float y = 320-60-i/8*80;
            levelSprite.position = ccp(x, y);
            levelSprite.scale = 0.6f;
            [self addChild:levelSprite z:1];
        }
        
    }
    return self;
}

@end
