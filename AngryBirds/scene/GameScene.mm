//
//  GameScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "GameScene.h"
#import "SlingShot.h"
#define SLINGSHOT_POS CGPointMake(85, 125)

@implementation GameScene

//+(id)scene{
//    CCScene *sc = [[[CCScene alloc]init]autorelease];
//    GameScene *gs = [[GameScene alloc]init];
//    [sc addChild:gs];
//    [gs release];
//    return sc;
//}

+ (id) sceneWithLevel:(int)level {
    CCScene *cs = [CCScene node];
    // 创建了一个节目ccscene
    GameScene *gs = [GameScene nodeWithLevel:level];
    [cs addChild:gs];
    return  cs;
}
+ (id) nodeWithLevel:(int)level {
    return [[[[self class] alloc] initWithLevel:level] autorelease];
}
- (id) initWithLevel:(int)level {
    self = [super init];
    if (self) {
        currentLevel = level;
        // 要创建精灵，创建背景
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg.png"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        bgSprite.position = ccp(winSize.width/2, winSize.height/2);
        bgSprite.scaleX = winSize.width/bgSprite.contentSize.width;
        bgSprite.scaleY = winSize.height/bgSprite.contentSize.height;
        [self addChild:bgSprite];
//        
//        NSString *scoreStr = [NSString stringWithFormat:@"分数:%d", score];
//        scoreLable = [[CCLabelTTF alloc] initWithString:scoreStr dimensions:CGSizeMake(300, 300) alignment:UITextAlignmentLeft fontName:@"Arial" fontSize:30];
//        scoreLable.position = ccp(450, 170);
//        [self addChild:scoreLable];

        CCSprite *leftShot = [CCSprite spriteWithFile:@"leftshot.png"];
        leftShot.position = ccp(85, 110);
        [self addChild:leftShot];
        
        CCSprite *rightShot = [CCSprite spriteWithFile:@"rightshot.png"];
        rightShot.position = ccp(85, 110);
        [self addChild:rightShot];

        slingShot = [[SlingShot alloc] init];
        slingShot.startPoint1 = ccp(82, 130);
        slingShot.startPoint2 = ccp(92, 128);
        slingShot.endPoint = SLINGSHOT_POS;
        slingShot.contentSize = CGSizeMake(480, 320);
        slingShot.position = ccp(240, 160);
        [self addChild:slingShot];
//
//        // 把标准的touch打开
//        self.isTouchEnabled = YES;
//        // 注册cocos2d特有的事件方法
//        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//        
        [self createWorld];
        [self createLevel];
    }
    return self;
}

-(void) createWorld {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    b2Vec2 gravity;
    gravity.Set(0.0f, -5.0f);
    
    bool doSleep = true;
    world = new b2World(gravity, doSleep);
    
    // 给world设置碰撞监听对象
//    contactListener = new MyContactListener(world, self);
//    world->SetContactListener(contactListener);
    
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0, 0);
    
    b2Body* groundBody = world->CreateBody(&groundBodyDef);
    
    b2PolygonShape groundBox;
    // bottom
    groundBox.SetAsEdge(b2Vec2(0,(float)87/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,(float)87/PTM_RATIO));
    groundBody->CreateFixture(&groundBox,0);
    
//    [self schedule:@selector(tick:)];
}

- (void) createLevel {
    // 1, 2
    NSString *s = [NSString stringWithFormat:@"%d", currentLevel];
    NSString *path = [[NSBundle mainBundle] pathForResource:s ofType:@"data"];
    NSLog(@"path is %@", path);
    NSArray *spriteArray = [JsonParser getAllSprite:path];
    for (SpriteModel *sm in spriteArray) {
        switch (sm.tag) {
            case PIG_ID:
            {
                CCSprite *pig = [[Pig alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
                [self addChild:pig];
                [pig release];
                break;
            }
            case ICE_ID:
            {
                CCSprite *ice = [[Ice alloc] initWithX:sm.x andY:sm.y andWorld:world  andLayer:self];
                [self addChild:ice];
                [ice release];
                break;
            }
            default:
                break;
        }
    }
    
    birds = [[NSMutableArray alloc] init];
    Bird *bird = [[Bird alloc] initWithX:160 andY:93 andWorld:world andLayer:self];
    Bird *bird2 = [[Bird alloc] initWithX:140 andY:93 andWorld:world andLayer:self];
    Bird *bird3 = [[Bird alloc] initWithX:120 andY:93 andWorld:world andLayer:self];
    
    [self addChild:bird];
    [self addChild:bird2];
    [self addChild:bird3];
    [birds addObject:bird];
    [birds addObject:bird2];
    [birds addObject:bird3];
    
    [bird release];
    [bird2 release];
    [bird3 release];
    
    [self jump];
}

- (void) jump {
    if (birds.count > 0 && !gameFinish) {
        currentBird = [birds objectAtIndex:0];
        CCJumpTo *action = [[CCJumpTo alloc] initWithDuration:1 position:SLINGSHOT_POS height:50 jumps:1];
        CCCallBlockN *jumpFinish = [[CCCallBlockN alloc] initWithBlock:^(CCNode *node) {
            gameStart = YES;
            currentBird.isReady = YES;
        }];
        // 动作序列 执行完action后在执行jumpFinish动作
        CCSequence *allActions = [CCSequence actions:action, jumpFinish, nil];
        [action release];
        [jumpFinish release];
        [currentBird runAction:allActions];
    }
}


@end
