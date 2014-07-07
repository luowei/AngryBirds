//
//  GameScene.h
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "JsonParser.h"
#import "SpriteBase.h"
#import "Bird.h"
#import "Pig.h"
#import "Ice.h"
#import "SlingShot.h"
#import "MyContactListener.h"

@interface GameScene : CCLayer
<SpriteDelegate, CCTargetedTouchDelegate>
{
    int currentLevel;
    CCLabelTTF *scoreLable;
    int score; //当前总分数
    NSMutableArray *birds;
    
    Bird *currentBird;
    BOOL gameStart;
    BOOL gameFinish;
    
    SlingShot *slingShot;
    int touchStatus;
    
    /* world */
    b2World* world;
    
    // 碰撞事件监听对象
    MyContactListener *contactListener;
}
// level 关卡的数 1, 2
+ (id) sceneWithLevel:(int)level;
- (id) initWithLevel:(int)level;

@end
