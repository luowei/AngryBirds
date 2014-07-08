//
//  Bird.m
//  AngryBirds
//
//  Created by luowei on 14-7-7.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Bird.h"

@implementation Bird
@synthesize isFly = _isFly, isReady = _isReady;

-(id)initWithX:(float)x andY:(float)y andWorld:(b2World *)world andLayer:(CCLayer <SpriteDelegate> *)layer
{
    myLayer = layer;
    imageUrl = @"bird";
    myWorld = world;
    self = [super initWithFile:[NSString stringWithFormat:@"%@1.png", imageUrl]];
    // 调用cocos2d里面的创建精灵的方法
    self.tag = BIRD_ID;
    self.position = ccp(x, y);
    HP = 10000;
    self.scale = 0.3f;
    
    return self;
}

-(void)setSpeedX:(float)x andY:(int)y andWorld:(b2World*)world{
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
    
    ballBodyDef.userData = self;
    b2Body *ballBody = world->CreateBody(&ballBodyDef);
    myBody = ballBody;
    
    // Create block shape
    b2PolygonShape blockShape;
    
    float size = 0.06f;
    b2Vec2 vertices[] = {
        b2Vec2(size ,-2*size),
        b2Vec2(2*size,-size),
        b2Vec2(2*size,size),
        
        b2Vec2(size,2*size),
        b2Vec2(-size,2*size),
        b2Vec2(-2*size,size),
        b2Vec2(-2*size,-size),
        b2Vec2(-size,-2*size)
    };
    blockShape.Set(vertices, 8);
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &blockShape;
    ballShapeDef.density = 80.0f;
    ballShapeDef.friction = 1.0f;
    ballShapeDef.restitution = 0.5f;
    ballBody->CreateFixture(&ballShapeDef);
    
    // Give shape initial impulse...
    //构建一个力向量
    b2Vec2 force = b2Vec2(x, y);
    //应用一个线性的冲量到球中心
    ballBody->ApplyLinearImpulse(force, ballBodyDef.position);
}


-(void)hitAnimationX:(float)x andY:(float)y{
    for (int i = 0; i<6; i++) {
        int range = 2;
        
        CCSprite *temp = [CCSprite spriteWithFile:@"yumao1.png"];
        temp.scale = (float)(arc4random()%5/10.1f);
        
        temp.position = CGPointMake(x+arc4random()%10*range-10, y+arc4random()%10*range-10);
        id actionMove = [CCMoveTo actionWithDuration:1 position:CGPointMake(x+arc4random()%10*range-10, y+arc4random()%10*range-10)];
        
        id actionAlpha = [CCFadeOut actionWithDuration:1];
        id actionRotate = [CCRotateBy actionWithDuration:1 angle:arc4random()%180];
        id actionMoveEnd = [CCCallFuncN actionWithTarget:self selector:@selector(runEnd:)];
        
        id mut =[CCSpawn actions:actionMove,actionAlpha,actionRotate,nil];
        [temp runAction:[CCSequence actions:mut, actionMoveEnd,nil]];
        
        [myLayer addChild:temp];
    }
}



@end