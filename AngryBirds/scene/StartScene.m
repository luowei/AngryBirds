//
//  StartScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "StartScene.h"
#import "ParticleManager.h"


@implementation StartScene

+ (id) scene {
    CCScene *sc = [CCScene node];
    StartScene *ss = [StartScene node];
    [sc addChild:ss];
    return sc;
}
+ (id) node {
    return [[[[self class] alloc] init] autorelease];
}
// 创建菜单
- (id) init {
    self = [super init];
    if (self) {
        
        // 得到屏幕宽高
        CGSize s = [[CCDirector sharedDirector] winSize];
        // 以图片startbg.png创建背景精灵
        // 然后设置精灵的位置为屏幕的中心点
        CCSprite *bgSprite = [CCSprite spriteWithFile:@"startbg.png"];
        bgSprite.scaleX=s.width/bgSprite.contentSize.width;
        bgSprite.scaleY=s.height/bgSprite.contentSize.height;
        [bgSprite setPosition:ccp(s.width/2.0f, s.height/2.0f)];
        [self addChild:bgSprite];
        
        CCSprite *angryBirdSprite = [CCSprite spriteWithFile:@"angrybird.png"];
        angryBirdSprite.scale = 0.5;
        [angryBirdSprite setPosition:ccp(s.width/2.0f, 250.0f)];
        [self addChild:angryBirdSprite];
        
        // 加一个菜单
        // 创建了一个菜单项，里面放了一个精灵beginSprite
        // 正常状态是这个精灵，选中这里设置为nil
        // 当点击了就调用self里面的beginGame:方法
        CCSprite *beginSprite = [CCSprite spriteWithFile:@"start.png"];
        CCMenuItemSprite *beginMenuItem = [CCMenuItemSprite itemFromNormalSprite:beginSprite selectedSprite:nil target:self selector:@selector(beginGame:)];
        beginMenuItem.scale = 0.5;
        CCMenu *menu = [CCMenu menuWithItems:beginMenuItem, nil];
        [menu setPosition:ccp(240.0f, 130.0f)];
        [self addChild:menu];
        
        //加一个定时器,每隔1s来执行tick方法
        [self schedule:@selector(tick:) interval:1.0f];
        
        //加雪花的粒子效果，取得雪花的粒子效果对象
        CCParticleSystem *snow = [[ParticleManager sharedParticleManager] particleWithType:ParticleTypeSnow];
        //把雪花粒子效果加入到self上
        [self addChild:snow];
    }
    return self;
}

- (void) tick:(double) dt {
    [self createOneBird];
}

- (void) createOneBird {
    // 创建一个小鸟
    CCSprite *bird = [[CCSprite alloc] initWithFile:@"bird1.png"];
    //arc4random()产生一个随机数,给小鸟一个缩放比例
    [bird setScale:(arc4random()%5)/10.0f];
    // 给bird一个动作 可以跳跃的动作
    [bird setPosition:ccp(50.0f+arc4random()%50, 70.0f)];
    // 设置一个终点
    CGPoint endPoint = ccp(360.0f+arc4random()%50, 70.0f);
    
    CGFloat height = arc4random()%100+50.0f;
    CGFloat time = 2.0f;
    
    // 创建一个动作，动作执行时间是time 2s 最终位置是endPoint, 最大高度height
    id actionJump = [CCJumpTo actionWithDuration:time position:endPoint height:height jumps:1];
    // 这是一个完成动作的函数
    id actionFinish = [CCCallFuncN actionWithTarget:self selector:@selector(actionFinish:)];
    // 定义了一个顺序的动作 首先执行actionJump 然后执行actionFinish动作
    CCSequence *allActions = [CCSequence actions:actionJump, actionFinish, nil];
    
    // 让bird执行一个动作
    [bird runAction:allActions];
    
    [self addChild:bird];
    [bird release];
}

// 加上小鸟撞到地板的粒子效果
- (void) actionFinish:(CCNode *)currentNode {
    // 得到爆破效果的粒子对象
    CCParticleSystem *explosition = [[ParticleManager sharedParticleManager] particleWithType:ParticleTypeBirdExplosion];
    // 把currentNode和粒子效果对象位置保持一样,让粒子效果在这个位置发生
    [explosition setPosition:[currentNode position]];
    
    [self addChild:explosition];
    
    // 只要这个方法被调用，就说明动作已经执行完成
    // currentNode其实就是bird
    // 从屏幕上删除这个currentNode;
    //[self removeChild:currentNode cleanup:YES];
    [currentNode removeFromParentAndCleanup:YES];
}


- (void) beginGame:(id)arg {
    NSLog(@"开始游戏");
    // 启动LevelScene剧场

}



@end
