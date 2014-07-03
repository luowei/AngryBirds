//
//  LoadingScene.m
//  AngryBirds
//
//  Created by luowei on 14-7-3.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "LoadingScene.h"

@implementation LoadingScene

+ (id) scene {
    // 创建了一个空的剧场
    CCScene *sc = [CCScene node];
    
    // 创建了一个我们自己的节目
    LoadingScene *ls = [LoadingScene node];
    
    // 把我们的节目加到通用的剧场上 CCScene
    [sc addChild:ls];
    
    return sc;
}
+ (id) node {
    return [[[[self class] alloc] init] autorelease];
}

-(void)onEnter{
    [super onEnter];
    
    // 通过导演类CCDirector来获取屏幕的宽高
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // 创建了一个精灵对象，这个对象就是一张图片
    CCSprite *sp = [CCSprite spriteWithFile:@"loading.png"];
    sp.scaleX=winSize.width/sp.contentSize.width;
    sp.scaleY=winSize.height/sp.contentSize.height;
    // ccp = CGPointMake
//    sp.scale = 0.5f;
    // 设置精灵的中心坐标
    [sp setPosition:ccp(winSize.width/2.0f, winSize.height/2.0f)];
    // 把精灵加入到self中 self就是节目
    [self addChild:sp];
    
    // 把@"Loading"字符串使用字体 arial16.fnt加载到CCLabelBMFont中
    loadingTitle = [[CCLabelBMFont alloc] initWithString:@"Loading" fntFile:@"arial16.fnt"];
    // 设置loadingTitle锚点为(0.0f, 0.0f);
    [loadingTitle setAnchorPoint:ccp(0.0f, 0.0f)];
    // 设置position
    [loadingTitle setPosition:ccp(winSize.width-80.0f, 10.0f)];
    // 让Loading字符串 每隔1s前进一个.
    [self addChild:loadingTitle];
    // 每隔2.0f来调用 [self loadTick:];方法
    [self schedule:@selector(loadTick:) interval:2.0f];

}

//
//- (id) init {
//    self = [super init];
//    if (self) { // 标准init方法
//        // 通过导演类CCDirector来获取屏幕的宽高
//        CGSize winSize = [[CCDirector sharedDirector] winSize];
//        // 创建了一个精灵对象，这个对象就是一张图片
//        CCSprite *sp = [CCSprite spriteWithFile:@"loading.png"];
//        // ccp = CGPointMake
//        // 设置精灵的中心坐标
//        [sp setPosition:ccp(winSize.width/2.0f, winSize.height/2.0f)];
//        // 把精灵加入到self中 self就是节目
//        [self addChild:sp];
//        
//        // 把@"Loading"字符串使用字体 arial16.fnt加载到CCLabelBMFont中
//        loadingTitle = [[CCLabelBMFont alloc] initWithString:@"Loading" fntFile:@"arial16.fnt"];
//        // 设置loadingTitle锚点为(0.0f, 0.0f);
//        [loadingTitle setAnchorPoint:ccp(0.0f, 0.0f)];
//        // 设置position
//        [loadingTitle setPosition:ccp(winSize.width-80.0f, 10.0f)];
//        // 让Loading字符串 每隔1s前进一个.
//        [self addChild:loadingTitle];
//        // 每隔2.0f来调用 [self loadTick:];方法
//        [self schedule:@selector(loadTick:) interval:2.0f];
//        
//    }
//    return self;
//}

- (void) loadTick:(double)dt {
    // 每隔2.0fs会来调用
    static int count;
    count++;
    // [loadingTitle string]原来字符串，在原来字符串后面追加  .
    NSString *s = [NSString stringWithFormat:
                   @"%@%@", [loadingTitle string], @"."];
    [loadingTitle setString:s];
    
    // 把loadingTitle上设置显示字符串 s
    if (count >= 1) {
        // 取消所有的定时器
        [self unscheduleAllSelectors];
        
        // 加载下一个剧场
        CCScene *sc = [StartScene scene];
        // 把当前剧场销毁，然后启动sc这个新的剧场
        [[CCDirector sharedDirector] replaceScene:sc];
    }
}
- (void) dealloc {
    [loadingTitle release], loadingTitle = nil;
    [super dealloc];
}


@end
