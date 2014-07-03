//
//  StartScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "StartScene.h"


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
        
        
    }
    return self;
}

- (void) beginGame:(id)arg {
    NSLog(@"开始游戏");
    // 启动LevelScene剧场

}



@end
